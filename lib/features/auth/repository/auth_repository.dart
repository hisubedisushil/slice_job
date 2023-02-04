import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';
import 'package:slice_job/core/models/authentication/user.dart';
import 'package:slice_job/core/models/base_response.dart';

final authRepositoryRef = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref);
});

abstract class AuthRepository {
  Future<AuthData?> getSession();
  Future<void> setSession(AuthData session);
  Future<BaseResponse> login(String username, String password);
  Future<BaseResponse> logout();
  Future<BaseResponse> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  );
  Future<BaseResponse> registerVerify(
    String email,
    String phone,
    String code,
  );
  Future<BaseResponse> resetPassword(
    String email,
    String code,
    String password,
  );
  Future<BaseResponse> forgotPassword(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);
  HiveDB get hive => _ref.read(hiveProvider);

  @override
  Future<AuthData?> getSession() async {
    try {
      final session = await hive.getSession();
      return session;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setSession(AuthData session) {
    return hive.setSession(session);
  }

  @override
  Future<BaseResponse> login(String username, String password) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: loginEndpoint,
      authType: AuthType.none,
      reqBody: {
        "email": username,
        "password": password,
      },
    );
    return response.fold((s) async {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final authData = AuthData.fromJson(json);
            return authData;
          },
        );
        await setSession(data.data);
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  ) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: registerEndpoint,
      authType: AuthType.none,
      reqBody: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "confirm_password": password,
      },
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final authData = User.fromJson(json);
            return authData;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> registerVerify(
    String email,
    String phone,
    String code,
  ) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: registerVerifyEndpoint,
      authType: AuthType.none,
      reqBody: {
        "email": email,
        "phone": phone,
        "code": code,
      },
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final authData = User.fromJson(json);
            return authData;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> logout() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: logoutEndpoint,
      authType: AuthType.none,
    );
    return response.fold((s) {
      hive.clearSession();
      if (s['status']) {
        return const BaseResponse(
          status: true,
          message: 'Log out Successful!',
          data: true,
        );
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> forgotPassword(String email) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: forgotPasswordEndpoint,
      authType: AuthType.none,
      reqBody: {
        "email": email,
      },
    );
    return response.fold((s) async {
      if (s['status']) {
        return BaseResponse<bool>(
            status: true, message: s['message'], data: true);
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> resetPassword(
    String email,
    String code,
    String password,
  ) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.post,
      endpoint: resetPasswordEndpoint,
      authType: AuthType.none,
      reqBody: {
        "email": email,
        "password": password,
        "code": code,
      },
    );
    return response.fold((s) {
      if (s['status']) {
        return BaseResponse<bool>(
            status: true, message: s['message'], data: true);
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }
}

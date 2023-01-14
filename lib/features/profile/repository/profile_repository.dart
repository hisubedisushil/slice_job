import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';

final profileRepositoryRef = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref);
});

abstract class ProfileRepository {
  Future<BaseResponse> getUserProfile();
  // Future<void> updateProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);
  HiveDB get hive => _ref.read(hiveProvider);

  @override
  Future<BaseResponse> getUserProfile() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: profileEndpoint,
      authType: AuthType.BEARER,
    );
    return response.fold((s) async {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final data = Profile.fromJson(json);
            return data;
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

  // @override
  // Future<BaseResponse> getUserProfile(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String phone,
  //   String password,
  // ) async {
  //   final response = await _api.request<Map<String, dynamic>>(
  //     reqType: DIO_METHOD.POST,
  //     endpoint: registerEndpoint,
  //     authType: AuthType.NONE,
  //     reqBody: {
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "email": email,
  //       "phone": phone,
  //       "password": password,
  //       "confirm_password": password,
  //     },
  //   );
  //   return response.fold((s) {
  //     if (s['status']) {
  //       final data = BaseResponse.fromJson(
  //         s,
  //         (p0) {
  //           final json = p0 as Map<String, dynamic>;
  //           final authData = User.fromJson(json);
  //           return authData;
  //         },
  //       );
  //       return data;
  //     } else {
  //       final message = s['message'] as String;
  //       final failure = Failure(
  //         message,
  //         FailureType.response,
  //       );
  //       return BaseResponse(status: false, message: message, data: failure);
  //     }
  //   }, (f) {
  //     final errorMessage = f.reason;
  //     return BaseResponse(status: false, message: errorMessage, data: f);
  //   });
  // }

}

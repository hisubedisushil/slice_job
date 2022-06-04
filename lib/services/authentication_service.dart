import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';

class AuthenticationService {
  static AuthenticationService service = AuthenticationService();

  Future<RegisterResponseData?> register({
    required DioController dio,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String rePassword,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'register',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone": phone,
          "password": password,
          "repassword": rePassword,
        },
      );
      log(prettyJson(response.data), name: 'Register Response');
      if (response.statusCode == 200) {
        RegisterResponseModel model = registerResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on DioError catch (e, s) {
      log('Register DioError!', stackTrace: s, error: e);
      if (e.response?.statusCode == 404) {
        log(prettyJson(e.response?.data), name: 'Register Error Response');
      }
      return null;
    } on Exception catch (e, s) {
      log('Register Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<bool> registerVerify({
    required DioController dio,
    required String email,
    required String phone,
    required String code,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'register-verify',
        data: {
          "email": email,
          "phone": phone,
          "code": code,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e, s) {
      log('Register Verify DioError!', stackTrace: s, error: e);
      if (e.response?.statusCode == 404) {
        log(
          prettyJson(e.response?.data),
          name: 'Register Verify Error Response',
        );
      }
      return false;
    } on Exception catch (e, s) {
      log('Register Verify Error!', stackTrace: s, error: e);
      return false;
    }
  }

  Future<LoginResponseData?> login({
    required DioController dio,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'login',
        data: {
          "email": email,
          "password": password,
        },
      );
      log(prettyJson(response.data), name: 'Login Response');
      if (response.statusCode == 200) {
        LoginResponseModel model = loginResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on DioError catch (e, s) {
      log('Login DioError!', stackTrace: s, error: e);
      if (e.response?.statusCode == 404) {
        log(prettyJson(e.response?.data), name: 'Login Error Response');
      }
      return null;
    } on Exception catch (e, s) {
      log('Login Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<LoginResponseData?> getToken({required DioController dio}) async {
    /// TODO #1: get and test response
    try {
      Response response = await dio.dioClient.post('get-token');
      log(prettyJson(response.data), name: 'Get Token Response');
      if (response.statusCode == 200) {
        LoginResponseModel model = loginResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on DioError catch (e, s) {
      log('Get Token DioError!', stackTrace: s, error: e);
      if (e.response?.statusCode == 404) {
        log(prettyJson(e.response?.data), name: 'Get Token Error Response');
      }
      return null;
    } on Exception catch (e, s) {
      log('Get Token Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<bool> logout({required DioController dio}) async {
    try {
      Response response = await dio.dioClient.post('logout');
      log(prettyJson(response.data), name: 'Logout Response');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e, s) {
      log('Logout DioError!', stackTrace: s, error: e);
      if (e.response?.statusCode == 404) {
        log(prettyJson(e.response?.data), name: 'Logout Error Response');
      }
      return false;
    } on Exception catch (e, s) {
      log('Logout Error!', stackTrace: s, error: e);
      return false;
    }
  }
}

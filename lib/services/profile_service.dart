import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/appled_job_model.dart';
import '../models/applied_jobs_response_model.dart';
import '../models/profile_model.dart';
import '../models/profile_response_model.dart';

class ProfileService {
  static ProfileService service = ProfileService();

  Future<ProfileModel?> getProfile({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('profile');
      log(
        prettyJson(response.data),
        name: 'Get Profile Response',
      );
      if (response.statusCode == 200) {
        ProfileResponseModel model = profileResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Profile Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<bool> updateProfile({
    required DioController dio,
    required String firstName,
    required String lastName,
    required String dob,
    required String nationality,
    required String gender,
    required String currentCity,
    required String qualification,
    required String experience,
    required String mobile,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'profile-update',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'dob': dob,
          'nationality': nationality,
          'gender': gender,
          'curr_country': currentCity,
          'curr_city': qualification,
          'qualification': qualification,
          'experience': experience,
          'mobile_number': mobile,
        },
      );

      log(prettyJson(response.data), name: 'Update Profile Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return false;
        }
        return true;
      } else {
        return false;
      }
    } on Exception catch (e, s) {
      log('Update Profile Error!', stackTrace: s, error: e);
      return false;
    }
  }

  Future<String> changePassword({
    required DioController dio,
    required String oldPassword,
    required String password,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'change-password',
        data: {
          'old_password': oldPassword,
          'password': password,
        },
      );

      log(prettyJson(response.data), name: 'Change Password Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('Change Password Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<List<AppliedJobModel>> getAppliedJobs({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('applied-jobs');
      log(prettyJson(response.data), name: 'Get Applied Jobs Response');
      if (response.statusCode == 200) {
        AppliedJobsResponseModel model = appliedJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Applied Jobs Error!', stackTrace: s, error: e);
      return [];
    }
  }
}

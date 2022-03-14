import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../constants/app_apis.dart';
import '../controllers/dio_controller.dart';
import '../models/all_jobs_response_model.dart';
import '../models/features_jobs_response_model.dart';
import '../models/job_detail_model.dart';
import '../models/job_detail_response_model.dart';
import '../models/job_model.dart';
import '../models/recent_jobs_response_model.dart';
import 'preference_service.dart';

class JobService {
  static JobService service = JobService();

  Future<AllJobsResponseModel?> getAllJobs({
    required DioController dio,
    int page = 1,
  }) async {
    try {
      Response response = await dio.dioClient.get('all-jobs?page=$page');
      log(
        prettyJson(response.data),
        name: 'Get All Jobs Response Page #$page',
      );
      if (response.statusCode == 200) {
        AllJobsResponseModel model = allJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get All Jobs Error! Page #$page', stackTrace: s, error: e);
      return null;
    }
  }

  Future<AllJobsResponseModel?> getSearchedJobs({
    required DioController dio,
    int page = 1,
    String title = '',
    String category = '',
    String type = '',
    String level = '',
    String salary = '',
    String education = '',
    String experience = '',
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'search-jobs?page=$page',
        data: {
          'job_tittle': title,
          'job_category': category,
          'job_type': type,
          'career_level': level,
          'job_salary': salary,
          'education_level': education,
          'experience': experience,
        },
      );
      log(response.requestOptions.uri.toString());
      log(
        prettyJson(response.data),
        name: 'Get Searched Jobs Response Page #$page',
      );
      if (response.statusCode == 200) {
        AllJobsResponseModel model = allJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Searched Jobs Error! Page #$page', stackTrace: s, error: e);
      return null;
    }
  }

  Future<AllJobsResponseModel?> getJobsByCategory({
    required DioController dio,
    int page = 1,
    required String categoryId,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        'category-jobs?job_cat_id=$categoryId&page=$page',
      );
      log(response.requestOptions.uri.toString());
      log(
        prettyJson(response.data),
        name: 'Get Jobs ByCategory Response Page #$page',
      );
      if (response.statusCode == 200) {
        AllJobsResponseModel model = allJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Jobs ByCategory Error! Page #$page', stackTrace: s, error: e);
      return null;
    }
  }

  Future<List<FeaturedJobData>> getFeaturedJobs({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('featured-jobs');
      log(prettyJson(response.data), name: 'Get Featured Jobs Response');
      if (response.statusCode == 200) {
        FeaturedJobsResponseModel model = featuresJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Featured Jobs Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobModel>> getRecentJobs({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('recent-jobs');
      log(prettyJson(response.data), name: 'Get Recent Jobs Response');
      if (response.statusCode == 200) {
        RecentJobsResponseModel model = recentJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Recent Jobs Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobModel>> getRelatedJobs({
    required DioController dio,
    required int jobCatId,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        'related-jobs?job_cat_id=$jobCatId',
      );
      log(prettyJson(response.data), name: 'Get Related Jobs Response');
      if (response.statusCode == 200) {
        RecentJobsResponseModel model = recentJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Related Jobs Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<JobDetailModel?> getJobDetail({
    required DioController dio,
    required String jobId,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-detail?id=$jobId');
      log(prettyJson(response.data), name: 'Get Job Detail Response');
      if (response.statusCode == 200) {
        JobDetailResponseModel model = jobDetailResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Job Detail Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<String> apply({
    required DioController dio,
    required String jobId,
    required String qualification,
    required String experience,
    String? cv,
    String? letter,
  }) async {
    try {
      String token = await PreferenceService.service.token;
      log(token);
      Map<String, dynamic> data = {
        'id': jobId,
        'qualification': qualification,
        'experience': experience,
      };

      if (cv != null) {
        data.addAll({
          'cv': await MultipartFile.fromFile(cv),
        });
      }

      if (letter != null) {
        data.addAll({
          'letter': await MultipartFile.fromFile(letter),
        });
      }

      FormData fd = FormData.fromMap(data);

      Response response = await Dio().post(
        '${AppApis.baseUrlV1}job-apply',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
          },
        ),
        data: fd,
      );

      log(prettyJson(response.data), name: 'Apply Job Response');

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
      log('Get Job Detail Error!', stackTrace: s, error: e);
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
}

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/all_jobs_response_model.dart';
import '../models/features_jobs_response_model.dart';
import '../models/job_model.dart';
import '../models/recent_jobs_response_model.dart';

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
}

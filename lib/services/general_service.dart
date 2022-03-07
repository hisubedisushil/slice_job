import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/company_model.dart';
import '../models/company_response_model.dart';
import '../models/countries_response_model.dart';
import '../models/country_model.dart';
import '../models/job_categories_response_model.dart';
import '../models/job_category_model.dart';
import '../models/job_type_model.dart';
import '../models/job_types_response_model.dart';

class GeneralService {
  static GeneralService service = GeneralService();

  Future<List<JobCategoryModel>> getAllJobCategories({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-category');
      log(prettyJson(response.data), name: 'Get All Job Categories Response');
      if (response.statusCode == 200) {
        JobCategoriesResponseModel model = jobCategoriesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get All Job Categories Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobCategoryModel>> getFeatureJobCategories({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('feature-category');
      log(
        prettyJson(response.data),
        name: 'Get Feature Job Categories Response',
      );
      if (response.statusCode == 200) {
        JobCategoriesResponseModel model = jobCategoriesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Feature Job Categories Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<CompanyModel>> getTopEmployers({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('top-employers');
      log(prettyJson(response.data), name: 'Get Top Employers Response');
      if (response.statusCode == 200) {
        CompanyResponseModel model = companyResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Top Employers Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<CountryModel>> getCountries({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('country');
      log(prettyJson(response.data), name: 'Get Country Response');
      if (response.statusCode == 200) {
        CountriesResponseModel model = countriesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Country Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobTypeModel>> getJobTypes({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-types');
      log(prettyJson(response.data), name: 'Get Job Types Response');
      if (response.statusCode == 200) {
        JobTypesResponseModel model = jobTypesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Job Types Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobTypeModel>> getJobCareerLevels({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-career-level');
      log(prettyJson(response.data), name: 'Get Job Career Levels Response');
      if (response.statusCode == 200) {
        JobTypesResponseModel model = jobTypesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Job Career Levels Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobTypeModel>> getJobSalaries({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-salary');
      log(prettyJson(response.data), name: 'Get Job Salaries Response');
      if (response.statusCode == 200) {
        JobTypesResponseModel model = jobTypesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Job Salaries Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobTypeModel>> getEducationLevels({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-education-level');
      log(prettyJson(response.data), name: 'Get Job Education Levels Response');
      if (response.statusCode == 200) {
        JobTypesResponseModel model = jobTypesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Job Education Levels Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<List<JobTypeModel>> getExperienceLevels({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('job-experience-level');
      log(prettyJson(response.data),
          name: 'Get Job Experience Levels Response');
      if (response.statusCode == 200) {
        JobTypesResponseModel model = jobTypesResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Job Experience Levels Error!', stackTrace: s, error: e);
      return [];
    }
  }
}

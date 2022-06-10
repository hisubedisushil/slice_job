import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/test_category_response_model.dart';
import '../models/test_finish_response_model.dart';
import '../models/test_start_response_model.dart';

class TestService {
  static TestService service = TestService();

  Future<TestCategoryResponseModel?> getTestCategories({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('test-category');
      log(
        prettyJson(response.data),
        name: 'Get Test Categories',
      );
      if (response.statusCode == 200) {
        TestCategoryResponseModel model = testCategoryResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Test Categories Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<TestStartResponseModel?> testStart({
    required DioController dio,
    required String category,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'test-start',
        data: {
          'category': category,
        },
      );
      log(response.requestOptions.uri.toString());
      log(
        prettyJson(response.data),
        name: 'Test Start Response',
      );
      if (response.statusCode == 200) {
        TestStartResponseModel model = testStartResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Test Start Error!', stackTrace: s, error: e);
      return null;
    }
  }

  Future<TestFinishResponseModel?> testFinish({
    required DioController dio,
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'test-finish',
        data: requestBody,
      );
      log(response.requestOptions.uri.toString());
      log(
        prettyJson(response.data),
        name: 'Test Finish Response',
      );
      if (response.statusCode == 200) {
        TestFinishResponseModel model = testFinishResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Test Finish Error!', stackTrace: s, error: e);
      return null;
    }
  }
}

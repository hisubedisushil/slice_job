import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/core/models/test/test_response.dart';

final testRepositoryRef = Provider<TestRepository>((ref) {
  return TestRepositoryImpl(ref);
});

abstract class TestRepository {
  Future<BaseResponse> getTestCategories();
  Future<BaseResponse> startTest();
  Future<BaseResponse> finishTest();
}

class TestRepositoryImpl implements TestRepository {
  TestRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);
  HiveDB get hive => _ref.read(hiveProvider);

  @override
  Future<BaseResponse> getTestCategories() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: testCategoriesEndpoint,
      authType: AuthType.BEARER,
    );
    return response.fold((s) async {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final testCategories = <TestCategory>[];
            for (var compnayJson in json) {
              if (compnayJson['id'] != null) {
                final parsedCompanyJson = TestCategory.fromJson(compnayJson);
                testCategories.add(parsedCompanyJson);
              }
            }
            return testCategories;
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
  Future<BaseResponse> startTest() async {
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

  @override
  Future<BaseResponse> finishTest() async {
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
}

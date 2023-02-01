import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/cv/cv_basic.dart';
import 'package:slice_job/core/models/job.dart';

final cvRepositoryRef = Provider<CVRepository>((ref) {
  return CVRepositoryImpl(ref);
});

abstract class CVRepository {
  Future<BaseResponse> updateCVBasicInfo(Map<String, String> data);
  Future<BaseResponse> updateCVContactInfo(Map<String, String> data);
  Future<BaseResponse> getCVBasicInfo();
  Future<BaseResponse> updateCVTargetJob(Map<String, String> data);
  Future<BaseResponse> getJobTitles(String categoryId);
  Future<BaseResponse> addExperience(Map<String, String?> data);
}

class CVRepositoryImpl implements CVRepository {
  CVRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);
  HiveDB get hive => _ref.read(hiveProvider);

  @override
  Future<BaseResponse> updateCVBasicInfo(Map<String, String> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvBasicEndpoint,
      authType: AuthType.BEARER,
      reqBody: data,
    );
    return response.fold((s) {
      if (s['status']) {
        return BaseResponse<bool>(
          status: true,
          message: s['message'],
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
  Future<BaseResponse> updateCVContactInfo(Map<String, String> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvContactEndpoint,
      authType: AuthType.BEARER,
      reqBody: data,
    );
    return response.fold((s) {
      if (s['status']) {
        return BaseResponse<bool>(
          status: true,
          message: s['message'],
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
  Future<BaseResponse> updateCVTargetJob(Map<String, String> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvTargetJobEndpoint,
      authType: AuthType.BEARER,
      reqBody: data,
    );
    return response.fold((s) {
      if (s['status']) {
        return BaseResponse<bool>(
          status: true,
          message: s['message'],
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
  Future<BaseResponse> getCVBasicInfo() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getCVBasicEndpoint,
      authType: AuthType.BEARER,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final cvBasic = CVBasic.fromJson(json);
            return cvBasic;
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
  Future<BaseResponse> getJobTitles(String categoryId) async {
    final response = await _api.request<Map<String, dynamic>>(
        reqType: DIO_METHOD.POST,
        endpoint: jobTitleEndpoint,
        authType: AuthType.NONE,
        reqBody: {
          'category_id': categoryId,
        });

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final countries = json.map((e) => JobTitle.fromJson(e)).toList();
            return countries;
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
  Future<BaseResponse> addExperience(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? cvWorkExperiencePostEndpoint
          : cvWorkExperienceUpdateEndpoint,
      authType: AuthType.BEARER,
      reqBody: data,
    );
    return response.fold((s) {
      if (s['status']) {
        return BaseResponse<bool>(
          status: true,
          message: s['message'],
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
}

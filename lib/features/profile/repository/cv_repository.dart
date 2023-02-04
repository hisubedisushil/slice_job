import 'package:dio/dio.dart';
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
  Future<BaseResponse> addEducation(Map<String, String?> data);
  Future<BaseResponse> addSkill(Map<String, String?> data);
  Future<BaseResponse> addLanguage(Map<String, String?> data);
  Future<BaseResponse> addTraining(Map<String, String?> data);
  Future<BaseResponse> addCertificate(Map<String, String?> data);
  Future<BaseResponse> deleteExperience(String id);
  Future<BaseResponse> deleteEducation(String id);
  Future<BaseResponse> deleteSkill(String id);
  Future<BaseResponse> deleteLanguage(String id);
  Future<BaseResponse> deleteTraining(String id);
  Future<BaseResponse> deleteCertificate(String id);
  Future<BaseResponse> uploadOriginalCV(String cvPath);
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

  @override
  Future<BaseResponse> deleteExperience(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvWorkExperienceDeleteEndpoint,
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> addEducation(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? cvEducationPostEndpoint
          : cvEducationUpdateEndpoint,
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
  Future<BaseResponse> deleteEducation(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvEducationDeleteEndpoint,
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> addSkill(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? '$cvSkillEndpoint-post'
          : '$cvSkillEndpoint-update',
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
  Future<BaseResponse> deleteSkill(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: '$cvSkillEndpoint-delete',
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> addLanguage(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? '$cvLanguageEndpoint-post'
          : '$cvLanguageEndpoint-update',
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
  Future<BaseResponse> deleteLanguage(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: '$cvLanguageEndpoint-delete',
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> addTraining(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? '$cvTrainingEndpoint-post'
          : '$cvTrainingEndpoint-update',
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
  Future<BaseResponse> deleteTraining(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: '$cvTrainingEndpoint-delete',
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> addCertificate(Map<String, String?> data) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: data['id'] == null
          ? '$cvCertificateEndpoint-post'
          : '$cvCertificateEndpoint-update',
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
  Future<BaseResponse> deleteCertificate(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: '$cvCertificateEndpoint-delete',
      authType: AuthType.BEARER,
      reqBody: {'id': id},
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
  Future<BaseResponse> uploadOriginalCV(String profileImage) async {
    final formDataFile = await MultipartFile.fromFile(profileImage);
    final response = await _api.uploadFormData<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: cvOriginalCVEndpoint,
      authType: AuthType.BEARER,
      reqBody: FormData.fromMap(
        {
          'cv': formDataFile,
        },
      ),
    );
    return response.fold((s) async {
      if (s['status']) {
        return BaseResponse<String>(
            status: true, message: '${s['message']}', data: '${s['message']}');
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

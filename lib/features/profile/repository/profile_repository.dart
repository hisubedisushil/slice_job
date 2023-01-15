import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/profile/applied_job_response.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';

final profileRepositoryRef = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref);
});

abstract class ProfileRepository {
  Future<BaseResponse> getUserProfile();
  Future<BaseResponse> getAppliedJobs();
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

  @override
  Future<BaseResponse> getAppliedJobs() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: appliedJobsEndpoint,
      authType: AuthType.BEARER,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobList = <AppliedJobs>[];
            for (var compnayJson in json) {
              if (compnayJson['id'] != null) {
                final parsedCompanyJson = AppliedJobs.fromJson(compnayJson);
                jobList.add(parsedCompanyJson);
              }
            }
            return jobList;
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

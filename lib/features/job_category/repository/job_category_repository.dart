import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/job_category.dart';

final jobCategoryRepositoryRef = Provider<JobCategoryRepository>((ref) {
  return JobCategoryRepositoryImpl(ref);
});

abstract class JobCategoryRepository {
  Future<BaseResponse> getFeaturedJobCategories();
  Future<BaseResponse> getJobCategories();
}

class JobCategoryRepositoryImpl implements JobCategoryRepository {
  JobCategoryRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponse> getFeaturedJobCategories() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.get,
      endpoint: featuredJobCategoriesEndpoint,
      authType: AuthType.none,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobCategoryList =
                json.map((e) => JobCategory.fromJson(e)).toList();
            return jobCategoryList;
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
  Future<BaseResponse> getJobCategories() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.get,
      endpoint: jobCategoriesEndpoint,
      authType: AuthType.none,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobCategoryList =
                json.map((e) => JobCategory.fromJson(e)).toList();
            return jobCategoryList;
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

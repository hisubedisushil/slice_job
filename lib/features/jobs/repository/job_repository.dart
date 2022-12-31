import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_detail.dart';

// typedef QrDetailsResponse = Either<Failure, QrDetails>;

final jobRepositoryRef = Provider<JobRepository>((ref) {
  return JobRepositoryImpl(ref);
});

abstract class JobRepository {
  Future<BaseResponse> getFeaturedJobs();
  Future<BaseResponse> getRecentJobs();
  Future<BaseResponse> getJobDetail(String jobKey);
  Future<BaseResponsePaginated> getJobsByCategory({
    required String jobCategoryId,
    required int page,
  });
}

class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponse> getFeaturedJobs() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: featuredJobsEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobList = json.map((e) => Company.fromJson(e)).toList();
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

  @override
  Future<BaseResponse> getRecentJobs() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: recentJobsEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobCategoryList = json.map((e) => Job.fromJson(e)).toList();
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
  Future<BaseResponse> getJobDetail(String jobKey) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: jobDetailEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'id': jobKey,
      },
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final jobDetail = JobDetail.fromJson(json);
            return jobDetail;
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
  Future<BaseResponsePaginated> getJobsByCategory({
    required String jobCategoryId,
    required int page,
  }) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getJobsByCategoryEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'job_cat_id': jobCategoryId,
        'page': page,
      },
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponsePaginated.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobCategoryList = json.map((e) => Job.fromJson(e)).toList();
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
        return BaseResponsePaginated(
          status: false,
          message: message,
          data: failure,
          page: '1',
          total: '0',
        );
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponsePaginated(
        status: false,
        message: errorMessage,
        data: f,
        page: '1',
        total: '0',
      );
    });
  }
}

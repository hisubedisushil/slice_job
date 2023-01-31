import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/country.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_detail.dart';
import 'package:slice_job/features/jobs/models/job_search.dart';

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
  Future<BaseResponsePaginated> searchJobs({
    required int page,
    required JobSearch search,
  });
  Future<BaseResponse> getJobTypes();
  Future<BaseResponse> getJobCareerLevels();
  Future<BaseResponse> getJobSalaries();
  Future<BaseResponse> getJobEducationLevels();
  Future<BaseResponse> getJobExperienceLevels();
  Future<BaseResponse> getCountries();
  Future<BaseResponse> getCities(String countryId);
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
            final jobList = <Company>[];
            for (var compnayJson in json) {
              if (compnayJson['id'] != null) {
                final parsedCompanyJson = Company.fromJson(compnayJson);
                if (parsedCompanyJson != null) {
                  jobList.add(parsedCompanyJson);
                }
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
          page: page.toString(),
          total: '0',
        );
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponsePaginated(
        status: false,
        message: errorMessage,
        data: f,
        page: page.toString(),
        total: '0',
      );
    });
  }

  @override
  Future<BaseResponsePaginated> searchJobs({
    required int page,
    required JobSearch search,
  }) async {
    final reqBody = search.toJson();
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.POST,
      endpoint: searchJobsEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'page': page,
      },
      reqBody: reqBody,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponsePaginated.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final searchedJobs = json.map((e) => Job.fromJson(e)).toList();
            return searchedJobs;
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
          page: page.toString(),
          total: '0',
        );
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponsePaginated(
        status: false,
        message: errorMessage,
        data: f,
        page: page.toString(),
        total: '0',
      );
    });
  }

  @override
  Future<BaseResponse> getJobTypes() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: jobTypesEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobTypeList = json.map((e) => JobType.fromJson(e)).toList();
            return jobTypeList;
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
  Future<BaseResponse> getJobCareerLevels() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getJobCareerLevelsEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobCareerLevelList =
                json.map((e) => JobType.fromJson(e)).toList();
            return jobCareerLevelList;
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
  Future<BaseResponse> getJobSalaries() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getJobSalariesEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobSalaryList = json.map((e) => JobType.fromJson(e)).toList();
            return jobSalaryList;
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
  Future<BaseResponse> getJobEducationLevels() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getJobEducationLevelsEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobEducationLevels =
                json.map((e) => JobType.fromJson(e)).toList();
            return jobEducationLevels;
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
  Future<BaseResponse> getJobExperienceLevels() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getJobExperienceLevelsEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobExperienceLevels =
                json.map((e) => JobType.fromJson(e)).toList();
            return jobExperienceLevels;
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
  Future<BaseResponse> getCountries() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: countriesEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final countries = json.map((e) => Country.fromJson(e)).toList();
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
  Future<BaseResponse> getCities(String countryId) async {
    final response = await _api.request<Map<String, dynamic>>(
        reqType: DIO_METHOD.POST,
        endpoint: citiesEndpoint,
        authType: AuthType.NONE,
        reqBody: {
          'country_id': countryId,
        });

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final countries = json.map((e) => City.fromJson(e)).toList();
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
}

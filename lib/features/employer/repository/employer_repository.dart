import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';

final employerRepositoryRef = Provider<EmployerRepository>((ref) {
  return EmployerRepositoryImpl(ref);
});

abstract class EmployerRepository {
  Future<BaseResponse> getTopEmployers();
  Future<BaseResponse> getEmployerByID(String id);
}

class EmployerRepositoryImpl implements EmployerRepository {
  EmployerRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponse> getTopEmployers() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.get,
      endpoint: topEmployersEndpoint,
      authType: AuthType.none,
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
  Future<BaseResponse> getEmployerByID(String id) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: METHOD.get,
      endpoint: employerJobs,
      authType: AuthType.none,
      queryParam: {
        'company_id': id,
      },
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final jobList = <Job>[];
            for (var jobJson in json) {
              if (jobJson['id'] != null) {
                final parsedJobJson = Job.fromJson(jobJson);
                jobList.add(parsedJobJson);
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';

// typedef QrDetailsResponse = Either<Failure, QrDetails>;

final employerRepositoryRef = Provider<EmployerRepository>((ref) {
  return EmployerRepositoryImpl(ref);
});

abstract class EmployerRepository {
  Future<BaseResponse> getTopEmployers();
}

class EmployerRepositoryImpl implements EmployerRepository {
  EmployerRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponse> getTopEmployers() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: topEmployersEndpoint,
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
}

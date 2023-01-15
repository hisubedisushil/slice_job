import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/dio/dio_client.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';

final dioHelper = Provider<DioHelper>((ref) {
  return DioHelper(ref);
});

class DioHelper {
  DioHelper(Ref ref) : _ref = ref;

  final Ref _ref;

  Dio get _dio => _ref.read(dioProvider);

  Future<Either<R, Failure>> download<R>(String file, String savePath) async {
    try {
      var response = await _dio.download(file, savePath);
      return Left(response.data);
    } on DioError catch (e) {
      return Right(e.toFailure);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  Future<Either<R, Failure>> uploadFormData<R>({
    required DIO_METHOD reqType,
    required String endpoint,
    required AuthType authType,
    required FormData reqBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParam,
  }) async {
    try {
      var response = await _dio.post(
        endpoint,
        data: reqBody,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
          },
          extra: {
            authToken: authType,
          },
        ),
      );
      final json = response.data! as R;
      return Left(json);
    } on DioError catch (e) {
      return Right(e.toFailure);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  Future<Either<R, Failure>> request<R>({
    required DIO_METHOD reqType,
    required String endpoint,
    required AuthType authType,
    Map<String, dynamic>? reqBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParam,
  }) async {
    try {
      final method = describeEnum(reqType);
      final data = <String, dynamic>{};
      if (reqBody != null) {
        data.addAll(reqBody);
      }
      var response = await _dio.request(
        endpoint,
        queryParameters: queryParam ?? <String, dynamic>{},
        data: data,
        options: Options(
          method: method,
          contentType: Headers.jsonContentType,
          extra: {
            authToken: authType,
          },
        ),
      );
      final json = response.data! as R;
      return Left(json);
    } on DioError catch (e) {
      return Right(e.toFailure);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }
}

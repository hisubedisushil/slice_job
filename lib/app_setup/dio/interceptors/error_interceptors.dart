import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorInterceptor extends Interceptor {
  ///
  ErrorInterceptor(this._read, this._dio);

  final Ref _read;
  final Dio _dio;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      _dio.interceptors.errorLock.lock();
      // await _read(appController.notifier).unAuthenticated();
      _dio.interceptors.errorLock.clear('Access Token has been expired..');
    }
    return super.onError(err, handler);
  }
}

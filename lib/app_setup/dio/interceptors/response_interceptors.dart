import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor(this._read, this._dio);

  final Ref _read;
  final Dio _dio;

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 200) return super.onResponse(response, handler);
    if (response.statusCode == 401 || response.statusCode == 403) {
      _dio.interceptors.errorLock.lock();
      // await _read(appController.notifier).unAuthenticated();
      _dio.interceptors.errorLock.clear('${response.statusMessage}');
    } else {
      return super.onResponse(response, handler);
    }
  }
}

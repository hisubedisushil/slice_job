// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor(this._dio);

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

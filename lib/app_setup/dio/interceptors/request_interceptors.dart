import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dio_client.dart';
import '../dio_util.dart';

class RequestInterceptor extends Interceptor {
  ///
  RequestInterceptor(this._read, this._dio);

  final Ref _read;
  final Dio _dio;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authType = options.extra[authToken] as AuthType;

    // if (options.uri.toString().contains(nearmeEndPoint)) {
    //   _dio.interceptors.requestLock.lock();
    //   options.headers["lsd-token"] = lsdToken;
    //   _dio.interceptors.requestLock.unlock();
    // }
    if (authType != AuthType.NONE) {
      _dio.interceptors.requestLock.lock();
      if (authType == AuthType.BEARER) {
        // final session = _read(obDbProvider).loggedUser();
        // if (session != null) {
        //   debugPrint("accessToken: ${session.token}");
        //   options.headers['Authorization'] = 'Bearer ${session.token}';
        //   _dio.interceptors.requestLock.unlock();
        // } else {
        //   // _read(appController.notifier).unAuthenticated();
        //   _dio.interceptors.requestLock.clear('Unable to get Access Token..');
        // }
      } else {
        // final basicToken = MeroMommaAuth().token();
        // log(basicToken);
        // options.headers['Authorization'] = 'Basic $basicToken';
        // _dio.interceptors.requestLock.unlock();
      }
    }
    // removing authType before requesting to server
    options.extra.removeWhere((key, value) => key == authToken);
    return super.onRequest(options, handler);
  }
}

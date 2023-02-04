import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';

import 'interceptors/error_interceptors.dart';
import 'interceptors/request_interceptors.dart';
import 'interceptors/response_interceptors.dart';

/// Key to access either token is required or not from the header extra map
const String authToken = 'authType';

final baseUrlProvider = Provider<String>((ref) => baseUrl);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final baseUrl = ref.watch(baseUrlProvider);
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 30000; //30 sec
  dio.options.receiveTimeout = 30000;
  dio.options.contentType = Headers.jsonContentType;
  dio.options.headers = <String, dynamic>{
    'Accept': Headers.jsonContentType,
  };
  dio.options.extra = <String, Object>{
    authToken: AuthType.none,
  };

  dio.interceptors.addAll([
    // if (kDebugMode) LogInterceptor(),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120,
    ),
    RequestInterceptor(ref),
    ResponseInterceptor(dio),
    ErrorInterceptor(dio),
  ]);
  return dio;
});

// final facebookBaseUrlProvider = Provider<String>((ref) => facebookBaseUrl);

// final facebookDioProvider = Provider<Dio>((ref) {
//   final dio = Dio();
//   final baseUrl = ref.watch(facebookBaseUrlProvider);
//   dio.options.baseUrl = baseUrl;
//   dio.options.connectTimeout = 30000; //30 sec
//   dio.options.receiveTimeout = 30000;
//   dio.options.contentType = Headers.jsonContentType;
//   dio.options.headers = <String, dynamic>{
//     'Accept': Headers.jsonContentType,
//   };
//   dio.options.extra = <String, Object>{
//     authToken: AuthType.BASIC,
//   };

//   dio.interceptors.addAll([
//     // if(kDebugMode)
//     // LogInterceptor(),
//     RequestInterceptor(ref.read, dio),
//     ResponseInterceptor(ref.read, dio),
//     ErrorInterceptor(ref.read, dio),
//   ]);
//   return dio;
// });

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/app_apis.dart';

class DioController with ChangeNotifier {
  final Dio _dio = Dio();

  DioController() {
    _dio.options.baseUrl = AppApis.baseUrlV1;
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
  }

  setInterceptor(InterceptorsWrapper wrapper) {
    _dio.interceptors.add(wrapper);
  }

  Dio get dioClient => _dio;
}

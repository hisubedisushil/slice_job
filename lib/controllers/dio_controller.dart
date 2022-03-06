import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:provider/provider.dart';

import '../constants/app_apis.dart';
import '../services/preference_service.dart';
import 'authentication_controller.dart';

class DioController with ChangeNotifier {
  final BuildContext _context;
  final Dio _dio = Dio();

  DioController(this._context) {
    _dio.options.baseUrl = AppApis.baseUrlV1;
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log(prettyJson(options.uri.toString()), name: 'API Request Url');
    log(prettyJson(options.headers), name: 'API Request Headers');
    String token = await PreferenceService.service.token;
    if (token.isNotEmpty) {
      options.headers.addAll(
        {'Authorization': 'Bearer $token'},
      );
    }
    return handler.next(options);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) async {
    log(prettyJson(response.data), name: 'API Response Data');
    return handler.next(response);
  }

  _onError(DioError error, ErrorInterceptorHandler handler) async {
    log(prettyJson(error.type.toString()), name: 'API Error');
    log(prettyJson(error.response?.data ?? {}), name: 'API Error');
    try {
      if (!((error.response?.data['status'] ?? false) as bool)) {
        log(error.response?.data['message'], name: 'Response Message');
        final auth = _context.read<AuthenticationController>();
        if (auth.isLoggedIn) {
          _context.read<AuthenticationController>().logOut();
        }
      }
    } catch (error, stacktrace) {
      log('API Error Caught', error: error, stackTrace: stacktrace);
    }
    return handler.next(error);
  }

  Dio get dioClient => _dio;
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/helpers/util/util.dart';

import '../dio_client.dart';
import '../dio_util.dart';

class RequestInterceptor extends QueuedInterceptorsWrapper {
  ///
  RequestInterceptor(this._ref);

  final Ref _ref;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authType = options.extra[authToken] as AuthType;
    if (authType == AuthType.bearer) {
      final session = await _ref.read(hiveProvider).getSession();
      if (session != null) {
        ezConsoleLog("accessToken: ${session.token}");
        options.headers['Authorization'] = 'Bearer ${session.token}';
      } else {
        // _read(appController.notifier).unAuthenticated();
      }
    }
    // removing authType before requesting to server
    options.extra.removeWhere((key, value) => key == authToken);
    return super.onRequest(options, handler);
  }
}

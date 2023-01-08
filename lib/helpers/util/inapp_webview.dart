import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/util.dart';

class SliceJobAppBrowser extends InAppBrowser {
  final options = InAppBrowserClassOptions(
    android: AndroidInAppBrowserOptions(
      shouldCloseOnBackButtonPressed: true,
    ),
    crossPlatform: InAppBrowserOptions(
      toolbarTopBackgroundColor: AppColors.primary,
    ),
  );

  @override
  Future onBrowserCreated() async {
    ezConsoleLog("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    ezConsoleLog("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    ezConsoleLog("Stopped $url");
  }

  @override
  void onProgressChanged(progress) {
    ezConsoleLog("Progress: $progress");
  }

  @override
  void onExit() {
    ezConsoleLog("Browser closed!");
  }

  void openUrl(String url) {
    openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(url)),
      options: options,
    );
  }
}



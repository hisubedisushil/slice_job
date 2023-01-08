import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';

Future<void> bootstrap(Widget Function() builder) async {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  _initialConfiguration();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // await runZonedGuarded(
  //   () async =>
  runApp(
    builder(),
    // ),
    // (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

void _initialConfiguration() async {
  late final Directory cacheDirectory;
  cacheDirectory = await getApplicationDocumentsDirectory();
  await HiveDB().init(cacheDirectory.path);
  // _setUpLogging();
  // other init logic...
}

// void _setUpLogging() => putLumberdashToWork(
//       withClients: [ColorizeLumberdash()], // todo: add print clients
//     );

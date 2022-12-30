import 'dart:async';
import 'dart:developer';

import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumberdash/lumberdash.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
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

  await runZonedGuarded(
    () async => runApp(
      await builder(),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

void _initialConfiguration() {
  _setUpLogging();
  // other init logic...
}

void _setUpLogging() => putLumberdashToWork(
      withClients: [ColorizeLumberdash()], // todo: add print clients
    );

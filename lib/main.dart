import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/bootstrap.dart';
import 'package:slice_job/helpers/extensions/provider_base_extensions.dart';

Future<void> main() async {
  WidgetsBinding wBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: wBinding);

  bootstrap(
    () => ProviderScope(
      observers: [
        LoggingObserver(),
      ],
      // child: const MyApp(),
      child: const App(),
    ),
  );
}

class LoggingObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) =>
      log('EZLOG => ${provider.nameOrType} was added.');

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer containers,
  ) =>
      log('EZLOG => ${provider.nameOrType} was disposed.');

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      log(
        'EZLOG => Updated ${provider.nameOrType} from:\n extras: {previousValue: $hashCode, newValue: $newValue}',
      );

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      log(
        'EZLOG => The ${provider.nameOrType} failed with: $error',
        stackTrace: stackTrace,
      );
}
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// import 'modules/navbar/controllers/nav_bar_controller.dart';
// import 'my_app.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   LicenseRegistry.addLicense(() async* {
//     final license = await rootBundle.loadString('google_fonts/OFL.txt');
//     yield LicenseEntryWithLineBreaks(['google_fonts'], license);
//   });

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => NavBarController(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

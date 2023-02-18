import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/bootstrap.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';
import 'package:slice_job/core/models/authentication/user.dart';

Future<void> main() async {
  WidgetsBinding wBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: wBinding);
  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;
  initHive();
  bootstrap(
    () => ProviderScope(
      observers: [
        LoggingObserver(),
      ],
      child: const App(),
    ),
  );
}

Future<void> initHive() async {
  final cachePath = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(cachePath.path);
  Hive.registerAdapter(AuthDataAdapter());
  Hive.registerAdapter(UserAdapter());
}

class LoggingObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    // log('EZLOGProviderObserver => ${provider.nameOrType} was added.');
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    // log('EZLOGProviderObserver => ${provider.nameOrType} was disposed.');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // log(
    //   'EZLOGProviderObserver => Updated ${provider.nameOrType} from:\n extras: {previousValue: $hashCode, newValue: $newValue}',
    // );
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    // log(
    //   'EZLOGProviderObserver => The ${provider.nameOrType} failed with: $error',
    //   stackTrace: stackTrace,
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/modules/splash/views/splash_view.dart';

import 'constants/app_colors.dart';
import 'controllers/authentication_controller.dart';
import 'controllers/blog_controller.dart';
import 'controllers/connectivity_controller.dart';
import 'controllers/dio_controller.dart';
import 'controllers/general_controller.dart';
import 'controllers/job_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/test_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cxt) => ConnectivityController(),
        ),
        ChangeNotifierProvider(
          create: (cxt) => DioController(),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController, DioController,
            AuthenticationController>(
          create: (cxt) => AuthenticationController(null, null),
          update: (cxt, conn, dio, auth) => AuthenticationController(
            conn,
            dio,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController,
            AuthenticationController, DioController, JobController>(
          create: (cxt) => JobController(null, null, null),
          update: (cxt, conn, auth, dio, pack) => JobController(
            conn,
            auth,
            dio,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController,
            AuthenticationController, DioController, TestController>(
          create: (cxt) => TestController(null, null, null),
          update: (cxt, conn, auth, dio, pack) => TestController(
            conn,
            auth,
            dio,
          ),
        ),
        ChangeNotifierProxyProvider3<ConnectivityController,
            AuthenticationController, DioController, ProfileController>(
          create: (cxt) => ProfileController(null, null, null),
          update: (cxt, conn, auth, dio, pack) => ProfileController(
            conn,
            auth,
            dio,
          ),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController, DioController,
            GeneralController>(
          create: (cxt) => GeneralController(null, null),
          update: (cxt, conn, dio, pack) => GeneralController(conn, dio),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController, DioController,
            BlogController>(
          create: (cxt) => BlogController(null, null),
          update: (cxt, conn, dio, blog) => BlogController(conn, dio),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Slice Job',
        theme: ThemeData(
          primarySwatch: AppColors.primary.toMaterialColor(),
          textTheme: GoogleFonts.alegreyaSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: DateTime.now().isAfter(DateTime(2022, 7, 1))
            ? const Scaffold()
            : const SplashView(),
        // home: const SplashView(),
      ),
    );
  }
}

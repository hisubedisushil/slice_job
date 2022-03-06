import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'controllers/authentication_controller.dart';
import 'controllers/connectivity_controller.dart';
import 'controllers/dio_controller.dart';
import 'modules/splash/views/splash_view.dart';

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
          create: (cxt) => DioController(cxt),
        ),
        ChangeNotifierProxyProvider2<ConnectivityController, DioController,
            AuthenticationController>(
          create: (cxt) => AuthenticationController(null, null),
          update: (cxt, conn, dio, auth) => AuthenticationController(
            conn,
            dio,
          ),
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
        home: const SplashView(),
      ),
    );
  }
}

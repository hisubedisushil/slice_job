import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';

final authRef = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});
final getFilterPropertiesRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    initialFetchCalls();
  }

  initialFetchCalls() async {
    await ref.read(getFilterPropertiesRef.notifier).getFilterProperties();
    await ref.read(authRef.notifier).getSession();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.primary.withOpacity(0.75),
        statusBarBrightness: Brightness.light,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(378, 806),
      builder: (BuildContext context, child) {
        return MaterialApp(
          onGenerateRoute: generateRoute,
          initialRoute: mainRoute,
          theme: ThemeData(
            primarySwatch: AppColors.primary.toMaterialColor(),
            textTheme: GoogleFonts.alegreyaSansTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

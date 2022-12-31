import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: move provider scope to routes? (needs research)

    return ScreenUtilInit(
      designSize: const Size(378, 806),
      builder: (BuildContext context, child) {
        return const AppView();
      },
    );
  }
}

class AppView extends ConsumerStatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  ConsumerState<AppView> createState() => _AppViewState();
}

class _AppViewState extends ConsumerState<AppView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(goRouterRef);
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: AppColors.primary.toMaterialColor(),
        textTheme: GoogleFonts.alegreyaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

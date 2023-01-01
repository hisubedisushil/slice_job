import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

final getJobCategoriesRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});
final getJobTypesRef = StateNotifierProvider<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});
final getJobCareerLevelsRef =
    StateNotifierProvider<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});
final getJobSalariesRef = StateNotifierProvider<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});
final getJobEducationLevelsRef =
    StateNotifierProvider<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});
final getJobExperienceLevelsRef =
    StateNotifierProvider<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    initialFetchCalls();
  }

  initialFetchCalls() {
// need to fetch some data before-hand here
    // all categories -> ref.read(jobCategoryRef.notifier).getJobCategories();
    //  all job types ->
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(getJobCategoriesRef.notifier).getJobCategories();
      ref.read(getJobTypesRef.notifier).getJobTypes();
      ref.read(getJobCareerLevelsRef.notifier).getJobCareerLevels();
      ref.read(getJobSalariesRef.notifier).getJobSalaries();
      ref.read(getJobEducationLevelsRef.notifier).getJobEducationLevels();
      ref.read(getJobExperienceLevelsRef.notifier).getJobExperienceLevels();
    });
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

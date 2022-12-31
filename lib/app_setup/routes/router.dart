import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slice_job/app_setup/routes/route_modal.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/job_category/views/job_category_screen.dart';
import 'package:slice_job/features/jobs/views/job_detail_screen.dart';
import 'package:slice_job/features/main/main_screen.dart';

final goRouterRef = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.mainRoute.path,
        name: RoutePaths.mainRoute.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
      ),
      GoRoute(
        path: RoutePaths.jobDetailRoute.path,
        name: RoutePaths.jobDetailRoute.routeName,
        builder: (BuildContext context, GoRouterState state) {
          final job = state.extra as Job;
          return JobDetailScreen(
            job: job,
          );
        },
      ),
      GoRoute(
        path: RoutePaths.jobCategoryScreenRoute.path,
        name: RoutePaths.jobCategoryScreenRoute.routeName,
        builder: (BuildContext context, GoRouterState state) {
          final jobCategory = state.extra as JobCategory;
          return JobCategoryScreen(
            jobCategory: jobCategory,
          );
        },
      ),
    ],
  );
});

/// [RoutePaths] list of all routes
class RoutePaths {
  static final RouteModal mainRoute = RouteModal(
    routeName: 'mainScreen',
    path: '/',
  );
  static final RouteModal splashRoute = RouteModal(
    routeName: 'splashPage',
    path: '/splashPage',
  );
  static final RouteModal loginRoute = RouteModal(
    routeName: 'loginPage',
    path: '/loginPage',
  );
  static final RouteModal signupRoute = RouteModal(
    routeName: 'signupPage',
    path: '/signupPage',
  );
  static final RouteModal jobDetailRoute = RouteModal(
    routeName: 'jobDetail',
    path: '/jobDetail',
  );
  static final RouteModal jobCategoryScreenRoute = RouteModal(
    routeName: 'jobCategoryScreen',
    path: '/jobCategoryScreen',
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slice_job/app_setup/routes/route_modal.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/blogs/views/blog_category_screen.dart';
import 'package:slice_job/features/blogs/views/blog_detail_screen.dart';
import 'package:slice_job/features/job_category/views/job_category_screen.dart';
import 'package:slice_job/features/jobs/views/job_detail_screen.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/modules/applied/views/applied_view.dart';
import 'package:slice_job/modules/cv/views/my_cv_view.dart';
import 'package:slice_job/modules/login/views/login_view.dart';
import 'package:slice_job/modules/pages/about_us_view.dart';
import 'package:slice_job/modules/pages/contact_view.dart';
import 'package:slice_job/modules/pages/faq_view.dart';
import 'package:slice_job/modules/profile/views/change_password_view.dart';
import 'package:slice_job/modules/profile/views/profile_update_view.dart';
import 'package:slice_job/modules/register/views/register_view.dart';
import 'package:slice_job/modules/remove_account/views/remove_account_view.dart';
import 'package:slice_job/modules/test/views/test_categories_view.dart';

final goRouterRef = Provider<GoRouter>(
  (ref) {
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
        GoRoute(
          path: RoutePaths.loginRoute.path,
          name: RoutePaths.loginRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: RoutePaths.registerRoute.path,
          name: RoutePaths.registerRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterView();
          },
        ),
        GoRoute(
          path: RoutePaths.aboutUsRoute.path,
          name: RoutePaths.aboutUsRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const AboutUsView();
          },
        ),
        GoRoute(
          path: RoutePaths.contactUsRoute.path,
          name: RoutePaths.contactUsRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const ContactView();
          },
        ),
        GoRoute(
          path: RoutePaths.faqsRoute.path,
          name: RoutePaths.faqsRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const FAQView();
          },
        ),
        GoRoute(
          path: RoutePaths.removeAccountRoute.path,
          name: RoutePaths.removeAccountRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const RemoveAccountView();
          },
        ),
        GoRoute(
          path: RoutePaths.profileUpdateRoute.path,
          name: RoutePaths.profileUpdateRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileUpdateView();
          },
        ),
        GoRoute(
          path: RoutePaths.changePasswordRoute.path,
          name: RoutePaths.changePasswordRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const ChangePasswordView();
          },
        ),
        GoRoute(
          path: RoutePaths.testCategoriesRoute.path,
          name: RoutePaths.testCategoriesRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const TestCategoriesView();
          },
        ),
        GoRoute(
          path: RoutePaths.myCVRoute.path,
          name: RoutePaths.myCVRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const MyCVView();
          },
        ),
        GoRoute(
          path: RoutePaths.jobAppliedRoute.path,
          name: RoutePaths.jobAppliedRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const AppliedView();
          },
        ),
        GoRoute(
          path: RoutePaths.blogDetailRoute.path,
          name: RoutePaths.blogDetailRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final blog = state.extra as Blog;
            return BlogDetailScreen(
              blog: blog,
            );
          },
        ),
         GoRoute(
          path: RoutePaths.blogCategoryRoute.path,
          name: RoutePaths.blogCategoryRoute.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final blogCategory = state.extra as BlogCategory;
            return BlogCategoryScreen(
              blogCategory: blogCategory,
            );
          },
        ),
      ],
    );
  },
);

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
  static final RouteModal registerRoute = RouteModal(
    routeName: 'registerPage',
    path: '/registerPage',
  );
  static final RouteModal jobDetailRoute = RouteModal(
    routeName: 'jobDetail',
    path: '/jobDetail',
  );
  static final RouteModal jobCategoryScreenRoute = RouteModal(
    routeName: 'jobCategoryScreen',
    path: '/jobCategoryScreen',
  );
  static final RouteModal aboutUsRoute = RouteModal(
    routeName: 'aboutUsPage',
    path: '/aboutUsPage',
  );
  static final RouteModal contactUsRoute = RouteModal(
    routeName: 'contactUsPage',
    path: '/contactUsPage',
  );
  static final RouteModal faqsRoute = RouteModal(
    routeName: 'faqsPage',
    path: '/faqsPage',
  );
  static final RouteModal removeAccountRoute = RouteModal(
    routeName: 'removeAccountPage',
    path: '/removeAccountPage',
  );

  static final RouteModal profileUpdateRoute = RouteModal(
    routeName: 'profileUpdatePage',
    path: '/profileUpdatePage',
  );
  static final RouteModal changePasswordRoute = RouteModal(
    routeName: 'changePasswordPage',
    path: '/changePasswordPage',
  );
  static final RouteModal testCategoriesRoute = RouteModal(
    routeName: 'testCategoriesPage',
    path: '/testCategoriesPage',
  );
  static final RouteModal myCVRoute = RouteModal(
    routeName: 'myCVPage',
    path: '/myCVPage',
  );

  static final RouteModal jobAppliedRoute = RouteModal(
    routeName: 'jobAppliedPage',
    path: '/jobAppliedPage',
  );

  static final RouteModal blogDetailRoute = RouteModal(
    routeName: 'blogDetailPage',
    path: '/blogDetailPage',
  );
  static final RouteModal blogCategoryRoute = RouteModal(
    routeName: 'blogCategoryPage',
    path: '/blogCategoryPage',
  );
  
}

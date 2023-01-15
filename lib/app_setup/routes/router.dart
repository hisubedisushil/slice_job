import 'package:flutter/material.dart';
import 'package:slice_job/app_setup/routes/route_not_found_screen.dart';
import 'package:slice_job/core/models/authentication/user.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/features/auth/views/login_screen.dart';
import 'package:slice_job/features/auth/views/register_screen.dart';
import 'package:slice_job/features/auth/views/verify_screen.dart';
import 'package:slice_job/features/blogs/views/blog_category_screen.dart';
import 'package:slice_job/features/blogs/views/blog_detail_screen.dart';
import 'package:slice_job/features/job_category/views/job_category_screen.dart';
import 'package:slice_job/features/jobs/views/applied_jobs_screen.dart';
import 'package:slice_job/features/jobs/views/job_detail_screen.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/features/others/views/about_us_screen.dart';
import 'package:slice_job/features/others/views/contact_us_screen.dart';
import 'package:slice_job/features/others/views/faqs_screen.dart';
import 'package:slice_job/features/test/views/test_category_screen.dart';
import 'package:slice_job/features/test/views/test_complete_screen.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/modules/cv/views/my_cv_view.dart';
import 'package:slice_job/modules/profile/views/change_password_view.dart';
import 'package:slice_job/modules/profile/views/profile_update_view.dart';
import 'package:slice_job/modules/remove_account/views/remove_account_view.dart';

const String mainRoute = 'mainScreen';
const String splashRoute = 'splashPage';
const String loginRoute = 'loginPage';
const String registerRoute = 'registerPage';
const String jobDetailRoute = 'jobDetail';
const String jobCategoryScreenRoute = 'jobCategoryScreen';
const String aboutUsRoute = 'aboutUsPage';
const String contactUsRoute = 'contactUsPage';
const String faqsRoute = 'faqsPage';
const String removeAccountRoute = 'removeAccountPage';
const String profileUpdateRoute = 'profileUpdatePage';
const String changePasswordRoute = 'changePasswordPage';
const String testCategoriesRoute = 'testCategoriesPage';
const String myCVRoute = 'myCVPage';
const String jobAppliedRoute = 'jobAppliedPage';
const String blogDetailRoute = 'blogDetailPage';
const String blogCategoryRoute = 'blogCategoryPage';
const String verifyRoute = 'registerVerifyPage';
const String testCompleteRoute = 'testCompletePage';

Route<dynamic> generateRoute(RouteSettings settings) {
  ezConsoleLog('Route settings: ${settings.name}');
  final routeName = settings.name;
  switch (routeName) {
    case mainRoute:
      return makeRoouteWithSettings(
        (p0) => const MainScreen(),
        routeName,
      );
    case jobDetailRoute:
      var job = settings.arguments as Job;
      return makeRoouteWithSettings(
        (p0) => JobDetailScreen(job: job),
        routeName,
      );
    case jobCategoryScreenRoute:
      var jobCategory = settings.arguments as JobCategory;
      return makeRoouteWithSettings(
        (p0) => JobCategoryScreen(jobCategory: jobCategory),
        routeName,
      );
    case loginRoute:
      return makeRoouteWithSettings(
        (p0) => const LoginScreen(),
        routeName,
      );
    case registerRoute:
      return makeRoouteWithSettings(
        (p0) => const RegisterScreen(),
        routeName,
      );
    case aboutUsRoute:
      return makeRoouteWithSettings(
        (p0) => const AboutUsScreen(),
        routeName,
      );
    case contactUsRoute:
      return makeRoouteWithSettings(
        (p0) => const ContactUsScreen(),
        routeName,
      );
    case faqsRoute:
      return makeRoouteWithSettings(
        (p0) => const FaqsScreen(),
        routeName,
      );
    case removeAccountRoute:
      return makeRoouteWithSettings(
        (p0) => const RemoveAccountView(),
        routeName,
      );
    case profileUpdateRoute:
      return makeRoouteWithSettings(
        (p0) => const ProfileUpdateView(),
        routeName,
      );
    case changePasswordRoute:
      return makeRoouteWithSettings(
        (p0) => const ChangePasswordView(),
        routeName,
      );
    case testCategoriesRoute:
      return makeRoouteWithSettings(
        (p0) => const TestCategoryScreen(),
        routeName,
      );
    case myCVRoute:
      return makeRoouteWithSettings(
        (p0) => const MyCVView(),
        routeName,
      );
    case jobAppliedRoute:
      return makeRoouteWithSettings(
        (p0) => const AppliedJobsScreen(),
        routeName,
      );
    case blogDetailRoute:
      var blog = settings.arguments as Blog;
      return makeRoouteWithSettings(
        (p0) => BlogDetailScreen(
          blog: blog,
        ),
        routeName,
      );
    case blogCategoryRoute:
      final blogCategory = settings.arguments as BlogCategory;
      return makeRoouteWithSettings(
        (p0) => BlogCategoryScreen(
          blogCategory: blogCategory,
        ),
        routeName,
      );
    case verifyRoute:
      final user = settings.arguments as User;
      return makeRoouteWithSettings(
        (p0) => VerifyScreen(user: user),
        routeName,
      );
    case testCompleteRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final category = args['category'] as TestCategory;
      final result = args['result'] as TestResult;
      return makeRoouteWithSettings(
        (p0) => TestCompleteScreen(
          category: category,
          result: result,
        ),
        routeName,
      );
    default:
      return makeRoouteWithSettings(
        (p0) => const RouteNotFoundScreen(),
        routeName,
      );
  }
}

Route<dynamic> makeRoouteWithSettings(
  Widget Function(BuildContext) builder,
  String? routeName,
) {
  return MaterialPageRoute<dynamic>(
    builder: builder,
    settings: RouteSettings(
      name: routeName,
    ),
  );
}

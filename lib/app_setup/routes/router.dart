import 'package:flutter/material.dart';
import 'package:slice_job/app_setup/routes/route_not_found_screen.dart';
import 'package:slice_job/core/models/authentication/user.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/features/auth/views/change_password_screen.dart';
import 'package:slice_job/features/auth/views/forgot_password_screen.dart';
import 'package:slice_job/features/auth/views/login_screen.dart';
import 'package:slice_job/features/auth/views/register_screen.dart';
import 'package:slice_job/features/auth/views/reset_password_screen.dart';
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
import 'package:slice_job/features/profile/views/cv/view_cv_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_certificate_form_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_education_form_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_experience_form_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_language_form_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_skill_form_screen.dart';
import 'package:slice_job/features/profile/views/cv/work_training_form_screen.dart';
import 'package:slice_job/features/profile/views/edit_profile_screen.dart';
import 'package:slice_job/features/test/views/test_category_screen.dart';
import 'package:slice_job/features/test/views/test_complete_screen.dart';
import 'package:slice_job/helpers/util/util.dart';
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
const String workExperienceFormRoute = 'workExperienceFormPage';
const String workEducationFormRoute = 'workEducationFormPage';
const String workSkillFormRoute = 'workSkillFormPage';
const String workLanguageFormRoute = 'workLanguageFormPage';
const String workTrainingFormRoute = 'workTrainingFormPage';
const String workCertificateFormRoute = 'workCertificateFormPage';
const String forgotPasswordRoute = 'forgotPasswordPage';
const String resetPasswordRoute = 'resetPasswordPage';

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
      final profile = settings.arguments as Profile;
      return makeRoouteWithSettings(
        (p0) => EditProfileScreen(
          profile: profile,
        ),
        routeName,
      );
    case changePasswordRoute:
      return makeRoouteWithSettings(
        (p0) => const ChangePasswordScreen(),
        routeName,
      );
    case testCategoriesRoute:
      return makeRoouteWithSettings(
        (p0) => const TestCategoryScreen(),
        routeName,
      );
    case myCVRoute:
      return makeRoouteWithSettings(
        (p0) => const ViewCVScreen(),
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
    case workExperienceFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkExperienceFormScreen(),
        routeName,
      );
    case workEducationFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkEducationFormScreen(),
        routeName,
      );
    case workSkillFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkSkillFormScreen(),
        routeName,
      );
    case workLanguageFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkLanguageFormScreen(),
        routeName,
      );
    case workTrainingFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkTrainingFormScreen(),
        routeName,
      );
    case workCertificateFormRoute:
      return makeRoouteWithSettings(
        (p0) => const WorkCertificateFormScreen(),
        routeName,
      );
    case forgotPasswordRoute:
      return makeRoouteWithSettings(
        (p0) => const ForgotPasswordScreen(),
        routeName,
      );
    case resetPasswordRoute:
      final email = settings.arguments as String;
      return makeRoouteWithSettings(
        (p0) => ResetPasswordScreen(
          email: email,
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

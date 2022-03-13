import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/modules/applied/views/applied_view.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/authentication_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../widgets/header_widget.dart';
import '../../cv/views/my_cv_view.dart';
import '../../login/views/login_view.dart';
import '../../register/views/register_view.dart';
import 'change_password_view.dart';
import 'profile_update_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final authentication = context.watch<AuthenticationController>();

    if (!authentication.isLoggedIn) {
      return SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.lock_closed_outline,
                    size: 60.0,
                    color: AppColors.red,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'To access the page you need to be login. '
                    'Please login if you already a register user or '
                    'register if you are not registered.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginView(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0.0,
                  ),
                  const SizedBox(height: 10.0),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterView(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.transparent,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final profile = context.watch<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const HeaderWidget(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: width / 4.0,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    backgroundImage: CachedNetworkImageProvider(
                      profile.profile?.photo ?? '',
                    ),
                    foregroundImage: CachedNetworkImageProvider(
                      profile.profile?.photo ?? '',
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.camera_outline,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${profile.profile?.firstName ?? ''} '
                      '${profile.profile?.lastName ?? ''}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Birth Date',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (profile.profile?.dob ?? '').isNotEmpty
                          ? Jiffy(profile.profile?.dob ?? '').yMMMd
                          : '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Nationality',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.nationality ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Gender',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.gender ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Current Location',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${profile.profile?.currCity ?? ''}'
                      '${(profile.profile?.currCity ?? '').isEmpty ? '' : ', '}'
                      '${profile.profile?.currCountry ?? ''}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.mobileNumber ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.email ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Total Job Experience',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.experience ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Highest Education Achieved',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.qualification ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: double.infinity),
                    Text(
                      'Profile Type',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile.profile?.userType ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileUpdateView(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.arrow_forward_circle,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChangePasswordView(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.arrow_forward_circle,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            // const SizedBox(height: 10.0),
            // MaterialButton(
            //   onPressed: () {},
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Test Yourself',
            //         style: TextStyle(
            //           color: AppColors.white,
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Icon(
            //         Ionicons.arrow_forward_circle,
            //         size: 32.0,
            //         color: AppColors.white,
            //       ),
            //     ],
            //   ),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   color: AppColors.primary,
            //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   minWidth: double.infinity,
            //   height: 56.0,
            //   elevation: 0.0,
            // ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyCVView(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View CV',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.arrow_forward_circle,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Download CV',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.arrow_forward_circle,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cxt) => const AppliedView(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Job Applied',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.arrow_forward_circle,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () async {
                bool result = await showDialog(
                  context: context,
                  builder: (context) => FutureProgressDialog(
                    authentication.logOut(),
                  ),
                );
                log(result.toString());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Ionicons.exit_outline,
                    size: 32.0,
                    color: AppColors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.red,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: double.infinity,
              height: 56.0,
              elevation: 0.0,
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}

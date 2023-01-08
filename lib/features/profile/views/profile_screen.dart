import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/home_screen_header.dart';
import 'package:slice_job/features/profile/views/profile_unauthenticated_view.dart';
import 'package:slice_job/features/profile/widgets/profile_detail_button_widget.dart';
import 'package:slice_job/features/profile/widgets/profile_detail_widget.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/models/profile_model.dart';

import '/packages/panara_dialogs/panara_dialogs.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(authRef.notifier).getSession();
    });
  }

  void _navigate(String routeName) {
    context.pushNamed(
      routeName,
    );
  }

  Widget _divider() => verticalSpacer(10.h);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final authState = ref.watch(authRef);

    if (authState.isAuthenticating || authState.isInitial) {
      return SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: 30.w,
              height: 30.w,
              child: const CircularProgressIndicator(),
            ).pXY(10.w, 50.h),
          ],
        ),
      );
    }

    if (!authState.isAuthenticated) {
      return const ProfileUnauthenticatedView();
    }
    final divider = _divider();

    // final profile = context.watch<ProfileController>();
    final profile = ProfileModel();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const HomeScreenHeaderWidget(),
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
                    backgroundImage: NetworkImage(
                      profile.photo ?? '',
                    ),
                    foregroundImage: NetworkImage(
                      profile.photo ?? '',
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
                          onPressed: _uploadProfileImage,
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
            verticalSpacer(20.h),
            ProfileDetailWidget(
              label: 'Name',
              value: '${profile.firstName ?? ''} '
                  '${profile.lastName ?? ''}',
            ),
            divider,
            ProfileDetailWidget(
              label: 'Date of Birth',
              value: Jiffy(profile.dob ?? '').yMMMd,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Nationality',
              value: profile.nationality,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Gender',
              value: profile.gender,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Current Location',
              value: '${profile.currCity ?? ''}'
                  '${(profile.currCity ?? '').isEmpty ? '' : ', '}'
                  '${profile.currCountry ?? ''}',
            ),
            divider,
            ProfileDetailWidget(
              label: 'Mobile Number',
              value: profile.mobileNumber,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Email Address',
              value: profile.email,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Total Job Experience',
              value: profile.experience,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Highest Education Achieved',
              value: profile.qualification,
            ),
            divider,
            ProfileDetailWidget(
              label: 'Profile Type',
              value: profile.userType,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () {
                _navigate(RoutePaths.profileUpdateRoute.routeName);
              },
              buttonText: 'Edit Profile',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () {
                _navigate(RoutePaths.changePasswordRoute.routeName);
              },
              buttonText: 'Change Password',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () {
                _navigate(RoutePaths.testCategoriesRoute.routeName);
              },
              buttonText: 'Test Yourself',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () {
                _navigate(RoutePaths.myCVRoute.routeName);
              },
              buttonText: 'View CV',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: _downloadCV,
              buttonText: 'Download CV',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () {
                _navigate(RoutePaths.jobAppliedRoute.routeName);
              },
              buttonText: 'Job Applied',
              iconData: Ionicons.arrow_forward_circle,
            ),
            divider,
            ProfileDetailButton(
              onPressed: () async {
                // bool result = await showDialog(
                //   context: context,
                //   builder: (context) => FutureProgressDialog(
                //     authentication.logOut(),
                //   ),
                // );
                // log(result.toString());
              },
              buttonText: 'Logout',
              color: AppColors.red,
              iconData: Ionicons.exit_outline,
            ),
            divider,
            verticalSpacer(60.h),
          ],
        ),
      ),
    );
  }

  _uploadProfileImage() async {
    FocusScope.of(context).requestFocus(FocusNode());

    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    CroppedFile? croppedFile;

    if (file != null) {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: file.files.single.path ?? '',
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Image',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
            title: 'Crop Profile Image',
            aspectRatioLockEnabled: true,
          ),
        ],
      );
    }

    if (croppedFile != null) {
      // String result = await showDialog(
      //   context: context,
      //   builder: (context) => FutureProgressDialog(
      //     context
      //         .read<ProfileController>()
      //         .uploadProfileImage(image: croppedFile?.path ?? ''),
      //   ),
      // );
      // log(result.toString());

      // if (result.isEmpty) {
      //   await PanaraInfoDialog.showAnimatedGrow(
      //     context,
      //     title: "Success",
      //     message: "Profile Image Updated Successfully.",
      //     buttonText: 'Okay',
      //     onTapDismiss: () => Navigator.pop(context),
      //     panaraDialogType: PanaraDialogType.success,
      //     barrierDismissible: true,
      //   );
      //   return;
      // } else {
      //   await PanaraInfoDialog.showAnimatedGrow(
      //     context,
      //     title: "Failed",
      //     message: result,
      //     buttonText: 'Okay',
      //     onTapDismiss: () => Navigator.pop(context),
      //     panaraDialogType: PanaraDialogType.error,
      //     barrierDismissible: true,
      //   );
      //   return;
      // }
    }
  }

  _downloadCV() async {
    FocusScope.of(context).requestFocus(FocusNode());

    // String result = await showDialog(
    //   context: context,
    //   builder: (context) => FutureProgressDialog(
    //     context.read<ProfileController>().getCVDownloadLink(),
    //   ),
    // );

    // if (result.isNotEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text(
    //         'You have successfully downloaded your CV.',
    //         textAlign: TextAlign.center,
    //       ),
    //       backgroundColor: AppColors.green,
    //     ),
    //   );
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Success",
    //     message: "CV Downloaded Successfully.",
    //     buttonText: 'Open CV',
    //     onTapDismiss: () {
    //       Navigator.pop(context);
    //       // OpenFile.open(result);
    //     },
    //     panaraDialogType: PanaraDialogType.success,
    //     barrierDismissible: true,
    //   );
    //   return;
    // } else {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Failed",
    //     message: result,
    //     buttonText: 'Okay',
    //     onTapDismiss: () => Navigator.pop(context),
    //     panaraDialogType: PanaraDialogType.error,
    //     barrierDismissible: true,
    //   );
    //   return;
    // }
  }
}

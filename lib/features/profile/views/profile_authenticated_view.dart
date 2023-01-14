import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/core/widgets/home_screen_header.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_shimmer_view.dart';
import 'package:slice_job/features/profile/widgets/profile_detail_button_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/image_util.dart';
import 'package:slice_job/helpers/util/util.dart';

final profileRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

final logoutRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class ProfileauthenticatedView extends ConsumerStatefulWidget {
  const ProfileauthenticatedView({super.key});

  @override
  ConsumerState<ProfileauthenticatedView> createState() =>
      _ProfileauthenticatedViewState();
}

class _ProfileauthenticatedViewState
    extends ConsumerState<ProfileauthenticatedView> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    Future.microtask(() => ref.read(profileRef.notifier).getProfile());
  }

  Widget _divider() => verticalSpacer(10.h);

  void _navigate(String routeName) {
    context.pushNamed(
      routeName,
    );
  }

  void _onLogout() {
    ref.read(logoutRef.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    final divider = _divider();
    ref.listen<AuthState>(
      logoutRef,
      (previous, next) {
        if (!next.isAuthenticating &&
            !next.isAuthenticated &&
            !next.isInitial) {
          ref.read(logoutRef.notifier).resetError();
          context.popUntilNamed(loginRoute);
          Future.delayed(const Duration(milliseconds: 200), () {
            ref.read(navBarController.notifier).setSelectedIndex(0);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'User Logged out!',
              ),
            ),
          );
        }
      },
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const HomeScreenHeaderWidget(),
      ),
      body: ref.watch<BaseState>(profileRef).maybeWhen(
        loading: () {
          return const ProfileAuthenticatedLoadingView();
        },
        success: (data, extraData) {
          final profile = data as Profile;
          var location = '';
          if ((profile.currCity ?? '').isNotEmpty) {
            location = '${profile.currCity}, ';
          }
          if ((profile.currCountry ?? '').isNotEmpty) {
            location = '$location${profile.currCountry}';
          }
          if (location.isEmpty) {
            location = 'Location Not Available';
          }
          var country = (profile.nationality ?? '').isEmpty
              ? 'Country'
              : profile.nationality ?? '';
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40.r),
                            child: Container(
                              height: 80.w,
                              width: 80.w,
                              color: AppColors.grey.withOpacity(0.25),
                              child: SliceImage(
                                profile.photo,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
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
                        ],
                      ),
                    ),
                    horizontalSpacer(20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.firstName ?? ''} '
                          '${profile.lastName ?? ''}',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        verticalSpacer(5.h),
                        Row(
                          children: [
                            const Icon(
                              Ionicons.location,
                              size: 20,
                            ),
                            horizontalSpacer(5.w),
                            Text(
                              location,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        verticalSpacer(5.h),
                        Row(
                          children: [
                            const Icon(
                              Ionicons.flag,
                              size: 20,
                            ),
                            horizontalSpacer(5.w),
                            Text(
                              country,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpacer(20.h),
                if ((profile.gender ?? '').isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Ionicons.people_circle,
                        size: 20,
                      ),
                      horizontalSpacer(15.w),
                      Text(
                        profile.gender ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    const Icon(
                      Ionicons.call,
                      size: 20,
                    ),
                    horizontalSpacer(15.w),
                    Text(
                      profile.mobileNumber ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                verticalSpacer(10.h),
                Row(
                  children: [
                    const Icon(
                      Ionicons.mail,
                      size: 20,
                    ),
                    horizontalSpacer(15.w),
                    Text(
                      profile.email ?? '',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                if ((profile.dob ?? '').isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Ionicons.calendar,
                        size: 20,
                      ),
                      horizontalSpacer(15.w),
                      Text(
                        profile.dob ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ).pB(10.h),
                verticalSpacer(10.h),
                Divider(
                  thickness: 0.5,
                  height: 5,
                  color: AppColors.grey,
                ),
                divider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          (profile.userType ?? '').isEmpty
                              ? '-'
                              : profile.userType ?? '',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        verticalSpacer(5.h),
                        Text(
                          'Account Type',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey,
                      width: 1,
                      height: 30.h,
                    ),
                    Column(
                      children: [
                        Text(
                          (profile.experience ?? '').isEmpty
                              ? '-'
                              : profile.experience ?? '',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        verticalSpacer(5.h),
                        Text(
                          'Job Experience',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.grey,
                      width: 1,
                      height: 30.h,
                    ),
                    Column(
                      children: [
                        Text(
                          (profile.qualification ?? '').isEmpty
                              ? '-'
                              : profile.qualification ?? '',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        verticalSpacer(5.h),
                        Text(
                          'Highest Education',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                divider,
                Divider(
                  thickness: 0.5,
                  height: 5,
                  color: AppColors.grey,
                ),
                verticalSpacer(10.h),
                ProfileDetailButton(
                  onPressed: () {
                    _navigate(profileUpdateRoute);
                  },
                  buttonText: 'Edit Profile',
                  prefixIconData: Ionicons.pencil,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                divider,
                ProfileDetailButton(
                  onPressed: () {
                    _navigate(changePasswordRoute);
                  },
                  buttonText: 'Change Password',
                  prefixIconData: Ionicons.lock_closed,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                divider,
                ProfileDetailButton(
                  onPressed: () {
                    _navigate(testCategoriesRoute);
                  },
                  buttonText: 'Test Yourself',
                  prefixIconData: Ionicons.paper_plane,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                divider,
                ProfileDetailButton(
                  onPressed: () {
                    _navigate(myCVRoute);
                  },
                  buttonText: 'View CV',
                  prefixIconData: Ionicons.document,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                divider,
                ProfileDetailButton(
                  onPressed: _downloadCV,
                  buttonText: 'Download CV',
                  prefixIconData: Ionicons.download,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                divider,
                ProfileDetailButton(
                  onPressed: () {
                    _navigate(jobAppliedRoute);
                  },
                  buttonText: 'Applied Jobs',
                  prefixIconData: Ionicons.chatbox,
                  iconData: Ionicons.arrow_forward_circle,
                ),
                verticalSpacer(30.h),
                Consumer(
                  builder: (context, ref, child) {
                    final isLoading = ref.watch(logoutRef).isAuthenticating;
                    return ProfileDetailButton(
                      onPressed: !isLoading ? _onLogout : () {},
                      buttonText: 'Logout',
                      color: AppColors.red,
                      foregroundColor: AppColors.white,
                      iconData: Ionicons.exit_outline,
                      isLoading: isLoading,
                    );
                  },
                ),
                verticalSpacer(30.h),
              ],
            ),
          );
        },
        error: (error) {
          return Container(
            color: AppColors.red,
          );
        },
        orElse: () {
          return Container();
        },
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

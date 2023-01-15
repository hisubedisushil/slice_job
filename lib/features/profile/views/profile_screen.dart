import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:open_file/open_file.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_view.dart';
import 'package:slice_job/features/profile/views/profile_unauthenticated_view.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';

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

  @override
  Widget build(BuildContext context) {
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

    return const ProfileAuthenticatedView();
  }
}

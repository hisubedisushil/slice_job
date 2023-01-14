import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/features/test/views/test_authenticated_view.dart';
import 'package:slice_job/features/test/views/test_unauthenticated_view.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';

class TestCategoryScreen extends ConsumerStatefulWidget {
  const TestCategoryScreen({super.key});

  @override
  ConsumerState<TestCategoryScreen> createState() => _TestCategoryScreenState();
}

class _TestCategoryScreenState extends ConsumerState<TestCategoryScreen> {
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
      return const TestUnauthenticatedView();
    }

    return const TestAuthenticatedView();
  }
}

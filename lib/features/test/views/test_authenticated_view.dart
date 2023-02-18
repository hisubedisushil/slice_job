import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/features/test/provider/test_provider.dart';
import 'package:slice_job/features/test/views/test_screen.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/image_util.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';

final testCategoryRef =
    StateNotifierProvider.autoDispose<TestProvider, BaseState>((ref) {
  return TestProvider(ref: ref);
});

final logoutRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class TestAuthenticatedView extends ConsumerStatefulWidget {
  const TestAuthenticatedView({super.key});

  @override
  ConsumerState<TestAuthenticatedView> createState() =>
      _TestAuthenticatedViewState();
}

class _TestAuthenticatedViewState extends ConsumerState<TestAuthenticatedView> {
  @override
  void initState() {
    super.initState();
    _getTestCategories();
  }

  void _getTestCategories() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(testCategoryRef.notifier).getTestCategories();
    });
  }

  Future<void> _onRefresh() {
    return Future.sync(
      () {
        ref.read(testCategoryRef.notifier).getTestCategories();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    ref.listen<AuthState>(
      logoutRef,
      (previous, next) {
        if (!next.isAuthenticating &&
            !next.isAuthenticated &&
            !next.isInitial) {
          ref.read(logoutRef.notifier).resetError();
          ref.read(authRef.notifier).getSession();
          context.pushLoginScreen();
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
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'Choose A Online Test Category',
          style: TextStyle(
            fontSize: 20.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ref.watch<BaseState>(testCategoryRef).maybeWhen(
        loading: () {
          return const LoadingShimmerWidget();
        },
        success: (data, extraData) {
          final tests = data as List<TestCategory>;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: GridView.builder(
              padding: EdgeInsets.only(
                top: 20.h,
                bottom: 40.h,
                left: 10.h,
                right: 10.h,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.h,
                mainAxisSpacing: 10.h,
              ),
              itemBuilder: (_, index) {
                final category = tests[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TestScreen(
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: kBoxDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: screenWidth / 3,
                          height: screenWidth / 3.8,
                          child: SliceImage(
                            category.image ?? '',
                            width: screenWidth / 3,
                            height: screenWidth / 5,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                              ),
                              color: AppColors.primary.withOpacity(0.15),
                            ),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                category.name ?? '',
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: tests.length,
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
}

class LoadingShimmerWidget extends StatelessWidget {
  const LoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    return GridView.builder(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 40.h,
        left: 10.h,
        right: 10.h,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.h,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (_, index) {
        return Container(
          decoration: kBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: screenWidth / 3,
                height: screenWidth / 3.8,
                child: shimmerWidget(
                  width: screenWidth / 4,
                  height: screenWidth / 5,
                ).pXY(10.w, 10.h),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                    color: AppColors.primary.withOpacity(0.15),
                  ),
                  width: double.infinity,
                  child: shimmerWidget(
                    width: 80.w,
                    height: 40.h,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 3,
    );
  }
}

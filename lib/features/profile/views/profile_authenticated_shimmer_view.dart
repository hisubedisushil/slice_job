import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';
import 'package:slice_job/helpers/util/util.dart';

class ProfileAuthenticatedLoadingView extends StatelessWidget {
  const ProfileAuthenticatedLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = verticalSpacer(10.h);
    final width = ScreenUtil().screenWidth;
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
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: AppColors.primary.withOpacity(0.75),
                    ).shimmer(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ).shimmer(),
                    ),
                  ],
                ),
              ),
              horizontalSpacer(20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shimmerWidget(height: 30, width: width / 2),
                    verticalSpacer(5.h),
                    Row(
                      children: [
                        shimmerWidget(width: 20, height: 20),
                        horizontalSpacer(5.w),
                        shimmerWidget(width: 150, height: 20)
                      ],
                    ),
                    verticalSpacer(5.h),
                    Row(
                      children: [
                        shimmerWidget(width: 20, height: 20),
                        horizontalSpacer(5.w),
                        shimmerWidget(width: 120, height: 20)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacer(20.h),
          Row(
            children: [
              shimmerWidget(width: 20, height: 20),
              horizontalSpacer(5.w),
              shimmerWidget(width: 120, height: 20)
            ],
          ),
          verticalSpacer(10.h),
          Row(
            children: [
              shimmerWidget(width: 20, height: 20),
              horizontalSpacer(5.w),
              shimmerWidget(width: 150, height: 20)
            ],
          ),
          verticalSpacer(10.h),
          Row(
            children: [
              shimmerWidget(width: 20, height: 20),
              horizontalSpacer(5.w),
              shimmerWidget(width: width / 2, height: 20)
            ],
          ),
          verticalSpacer(10.h),
          Divider(
            thickness: 0.5,
            height: 5,
            color: AppColors.grey,
          ).shimmer(),
          divider,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  shimmerWidget(width: 30, height: 20),
                  verticalSpacer(5.w),
                  shimmerWidget(width: 75, height: 20)
                ],
              ),
              Container(
                color: Colors.grey,
                width: 1,
                height: 30.h,
              ).shimmer(),
              Column(
                children: [
                  shimmerWidget(width: 30, height: 20),
                  verticalSpacer(5.w),
                  shimmerWidget(width: 75, height: 20)
                ],
              ),
              Container(
                color: Colors.grey,
                width: 1,
                height: 30.h,
              ).shimmer(),
              Column(
                children: [
                  shimmerWidget(width: 30, height: 20),
                  verticalSpacer(5.w),
                  shimmerWidget(width: 75, height: 20)
                ],
              ),
            ],
          ),
          divider,
          Divider(
            thickness: 0.5,
            height: 5,
            color: AppColors.grey,
          ).shimmer(),
          verticalSpacer(10.h),
          shimmerWidget(
            height: 56.h,
          ),
          verticalSpacer(10.h),
          shimmerWidget(height: 56.h),
          verticalSpacer(10.h),
          shimmerWidget(height: 56.h),
          verticalSpacer(30.h),
        ],
      ),
    );
  }
}

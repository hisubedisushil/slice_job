import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';

class FeaturedJobCategoryShimmerWidget extends StatelessWidget {
  const FeaturedJobCategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        itemBuilder: (cxt, index) {
          final width = 50 + (index & 2) * 20;
          return ActionChip(
            label: shimmerWidget(width: width.h, height: 20),
            backgroundColor: AppColors.primary,
          ).shimmer();
        },
        separatorBuilder: (cxt, index) {
          return const SizedBox(width: 5.0);
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

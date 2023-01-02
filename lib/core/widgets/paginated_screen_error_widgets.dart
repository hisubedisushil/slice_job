import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

class FirstPageError extends StatelessWidget {
  const FirstPageError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacer(50.h),
        Icon(
          Ionicons.sad_outline,
          color: AppColors.grey,
          size: 40.w,
        ),
        verticalSpacer(10.h),
        Text(
          message,
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    ).pXY(10.h, 10.h);
  }
}

class NewPageError extends StatelessWidget {
  const NewPageError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacer(10.h),
        Icon(
          Ionicons.sad_outline,
          color: AppColors.grey,
          size: 40.w,
        ),
        verticalSpacer(10.h),
        Text(
          message,
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    ).pXY(10.h, 10.h);
  }
}

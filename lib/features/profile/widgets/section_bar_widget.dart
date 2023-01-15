import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';

class SectionBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SectionBarWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: kBoxDecoration.copyWith(
        color: AppColors.primary.withOpacity(0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (onTap != null)
            IconButton(
              onPressed: onTap,
              iconSize: 20.w,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                maxHeight: 35.h,
              ),
              splashRadius: 24.r,
              icon: Icon(
                Ionicons.add,
                size: 24.0,
                color: AppColors.black,
              ),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

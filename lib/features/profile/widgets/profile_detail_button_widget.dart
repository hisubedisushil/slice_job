import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';

class ProfileDetailButton extends StatelessWidget {
  const ProfileDetailButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.iconData,
    this.color,
  });

  final void Function() onPressed;
  final String buttonText;
  final IoniconsData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      color: color ?? AppColors.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: double.infinity,
      height: 56.h,
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            iconData,
            size: 32.w,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}

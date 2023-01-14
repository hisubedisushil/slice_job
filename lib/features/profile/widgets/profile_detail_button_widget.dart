import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';

class ProfileDetailButton extends StatelessWidget {
  const ProfileDetailButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.iconData,
    this.prefixIconData,
    this.color,
    this.foregroundColor,
    this.isLoading = false,
  });

  final void Function() onPressed;
  final String buttonText;
  final IoniconsData iconData;
  final Color? color;
  final Color? foregroundColor;
  final IoniconsData? prefixIconData;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? AppColors.primary.withOpacity(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        side: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: double.infinity,
      height: 56.h,
      elevation: 0.0,
      child: isLoading
          ? SizedBox(
              width: 32.w,
              height: 32.w,
              child: CircularProgressIndicator(
                color: AppColors.kColorWhite,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (prefixIconData != null)
                  Icon(
                    prefixIconData,
                    size: 25.w,
                    color: foregroundColor ?? AppColors.black,
                  ).pR(10.w),
                Expanded(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: foregroundColor ?? AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  iconData,
                  size: 32.w,
                  color: foregroundColor ?? AppColors.black,
                ),
              ],
            ),
    );
  }
}

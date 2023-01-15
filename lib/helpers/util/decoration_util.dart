import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/util.dart';

final kBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10.r),
  color: AppColors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey[200]!,
      blurRadius: 10,
      spreadRadius: 1,
    ),
  ],
);

InputDecoration getFormInputDecoration({
  String? hint,
  required IconData? suffix,
  required IconData? prefix,
  VoidCallback? onTapSuffix,
  String? labelText,
  bool isDense = false,
  bool noBorder = false,
  String? customPrefix,
  VoidCallback? onTapPrefix,
  dynamic? labelIconData,
  String? errorText,
  Color? suffixColor,
}) =>
    noBorder
        ? const InputDecoration.collapsed(
            hintText: '',
          )
        : InputDecoration(
            errorText: errorText,
            suffixIcon: suffix == null
                ? null
                : InkWell(
                    onTap: onTapSuffix,
                    child: Icon(
                      suffix,
                      size: 24,
                      color: suffixColor ?? AppColors.red.withRed(200),
                    ),
                  ),
            prefixIcon: customPrefix != null
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        customPrefix,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : prefix == null
                    ? null
                    : InkWell(
                        onTap: onTapPrefix,
                        child: Icon(
                          prefix,
                          size: 24,
                          color: AppColors.red.withRed(200),
                        ),
                      ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 50.w,
              minHeight: 40.h,
            ),
            labelText: labelText,
            contentPadding: isDense
                ? EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h)
                : EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            hintText: hint,
            isDense: isDense,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
            label: labelIconData != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(labelIconData),
                      horizontalSpacer(10.w),
                      Text(
                        hint ?? 'label',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  )
                : Text(
                    hint ?? 'label',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: kStyleFocusBorder,
            errorBorder: kStyleErrorBorder,
            enabledBorder: kStyleEnabledBorder,
            border: const OutlineInputBorder(),
          );

final kStyleFocusBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: AppColors.primary,
    width: 2,
  ),
);

final kStyleErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: AppColors.red,
    width: 1,
  ),
);

final kStyleEnabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: AppColors.primary,
    width: 1,
  ),
);

import 'package:flutter/material.dart';
import 'package:slice_job/constants/app_colors.dart';

final kBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: AppColors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey[200]!,
      blurRadius: 10,
      spreadRadius: 1,
    ),
  ],
);

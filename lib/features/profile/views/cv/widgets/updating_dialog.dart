import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/helpers/util/util.dart';

class UpdatingCVInfoDialog extends StatelessWidget {
  const UpdatingCVInfoDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpacer(20.h),
          const CircularProgressIndicator(),
          verticalSpacer(20.h),
          Text('$message...'),
          verticalSpacer(20.h),
        ],
      ),
    );
  }
}

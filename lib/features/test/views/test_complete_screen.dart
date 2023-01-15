import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/helpers/util/util.dart';

class TestCompleteScreen extends StatelessWidget {
  const TestCompleteScreen({
    super.key,
    required this.category,
    required this.result,
  });

  final TestCategory category;
  final TestResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name ?? '',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 80.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Thank you for playing Slice Online Test!',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Your Test Result',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Question\nNumber",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Your\nAnswer",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Correct\nAnswer",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.4),
                  ),
                ),
                for (Answer ans in (result.entranceResult ?? []))
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          (ans.qno ?? '').toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          ans.option ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          ans.answer ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          (ans.answer == ans.option)
                              ? Ionicons.checkmark_circle
                              : Ionicons.close_circle,
                          color: (ans.answer == ans.option)
                              ? AppColors.green
                              : AppColors.red,
                        ),
                      ),
                    ],
                    decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(0.3),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            verticalSpacer(20.h),
            Text(
              'Your Score is '
              '${result.totalScore ?? 0}',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            verticalSpacer(20.h),
            Text(
              'Congratulations, you played very well!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
            verticalSpacer(20.h),
            MaterialButton(
              onPressed: () {
                openUrl(result.certificateLink ?? '');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 120.0,
              height: 44.0,
              elevation: 0.0,
              child: Text(
                'Get Your Test Certificate Here',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

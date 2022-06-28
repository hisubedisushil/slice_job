import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/models/job_detail_model.dart';

import '../../navbar/views/nav_bar_view.dart';

class JobSuccessView extends StatelessWidget {
  final JobDetailModel model;

  const JobSuccessView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.checkmark_circle_outline,
                      size: 60.0,
                      color: AppColors.green,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Congratulation! You have successfully applied for '
                      'this job. '
                      '${(model.onlineExam == 'yes') ? 'Please use a web browser to attempt an Online Job Interview for your applied job.' : 'Please check more detail in your email.'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      model.onlineExam == 'yes'
                          ? 'Please use a web browser to attempt an Online '
                              'Job Interview for your applied job.'
                          : 'Please check more detail in your email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NavBarView(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: AppColors.green,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

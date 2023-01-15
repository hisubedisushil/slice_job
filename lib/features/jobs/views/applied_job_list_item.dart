import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/profile/applied_job_response.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/image_util.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';

class AppliedJobListItem extends StatelessWidget {
  final AppliedJobs appliedJob;

  const AppliedJobListItem({
    Key? key,
    required this.appliedJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: SliceImage(
                appliedJob.company?.logo ?? '',
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appliedJob.job?.jobTittle ?? '',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      Icon(
                        Ionicons.business_outline,
                        size: 18.0,
                        color: AppColors.black,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        appliedJob.company?.name ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      Text(
                        'Applied On ',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        appliedJob.appliedDate ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  ActionChip(
                    onPressed: () {},
                    label: Text(
                      appliedJob.status ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppliedJobShimmerItem extends StatelessWidget {
  const AppliedJobShimmerItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: shimmerWidget(
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerWidget(
                    width: 200.w,
                    height: 20.h,
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      shimmerWidget(
                        width: 20.w,
                        height: 20.h,
                      ),
                      const SizedBox(width: 5.0),
                      shimmerWidget(
                        width: 80.w,
                        height: 15.h,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  Row(
                    children: [
                      shimmerWidget(
                        width: 50.w,
                        height: 15.h,
                      ),
                      const SizedBox(width: 2.5),
                      shimmerWidget(
                        width: 50.w,
                        height: 15.h,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.5),
                  shimmerWidget(
                    width: 100.w,
                    height: 15.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ).pX(10.w);
  }
}

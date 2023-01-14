import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';
import 'package:slice_job/helpers/util/util.dart';

class RecentJobListItem extends StatelessWidget {
  final Job job;

  const RecentJobListItem({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          jobDetailRoute,
          extra: job,
        );
      },
      borderRadius: BorderRadius.circular(10.0),
      child: DecoratedBox(
        decoration: kBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: job.company?.logo ?? '',
                  errorWidget: (cxt, str, val) {
                    return SizedBox(
                      height: 62.0,
                      width: 62.0,
                      child: Center(
                        child: Icon(
                          Ionicons.alert_circle_outline,
                          color: AppColors.red,
                          size: 36.0,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.contain,
                  height: 80.w,
                  width: 80.w,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.jobTittle ?? '',
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
                          job.company?.name ?? '',
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
                        Icon(
                          Ionicons.calendar_outline,
                          size: 18.0,
                          color: AppColors.black,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '${Jiffy().diff(Jiffy(job.postDate, 'dd MMM y hh:mm:ss'), Units.DAY)} days ago',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecentJobListShimmerItem extends StatelessWidget {
  const RecentJobListShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              color: Colors.white,
              child: shimmerWidget(width: 80.w, height: 80.w),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacer(5),
                  shimmerWidget(height: 30),
                  verticalSpacer(5),
                  Row(
                    children: [
                      shimmerWidget(width: 20, height: 20),
                      horizontalSpacer(5),
                      shimmerWidget(width: 150, height: 20),
                    ],
                  ),
                  verticalSpacer(4),
                  Row(
                    children: [
                      shimmerWidget(width: 20, height: 20),
                      horizontalSpacer(5),
                      shimmerWidget(width: 100, height: 20),
                    ],
                  ),
                  verticalSpacer(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';

import '../../../constants/app_colors.dart';
import '../../../models/job_model.dart';
import '../views/job_detail_view.dart';

class JobListItemSingle extends StatelessWidget {
  final JobModel job;

  const JobListItemSingle({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (cxt) => JobDetailView(job: job),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: job.company?.photo ?? '',
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
                  height: 62.0,
                  width: 62.0,
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

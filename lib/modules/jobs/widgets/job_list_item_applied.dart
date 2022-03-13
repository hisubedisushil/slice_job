import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/app_colors.dart';
import '../../../models/appled_job_model.dart';

class JobListItemApplied extends StatelessWidget {
  final AppliedJobModel model;

  const JobListItemApplied({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                  imageUrl: model.company?.photo ?? '',
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
                  fit: BoxFit.cover,
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
                      model.job?.jobTittle ?? '',
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
                          model.company?.name ?? '',
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
                          model.appliedDate ?? '',
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
                        model.status ?? '',
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
      ),
    );
  }
}

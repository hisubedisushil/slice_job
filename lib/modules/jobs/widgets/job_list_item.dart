import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/app_colors.dart';
import '../../../models/features_jobs_response_model.dart';
import '../views/job_detail_view.dart';

class JobListItem extends StatefulWidget {
  final FeaturedJobData item;

  const JobListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<JobListItem> createState() => _JobListItemState();
}

class _JobListItemState extends State<JobListItem> {
  bool _isMore = false;

  final List<String> _jobs = [
    'Sales Officer',
    'Software Developer',
    'Regional Project Lead Isp',
    'Jr.fiber Technician',
    'Sr. Fiber Technician',
    'Regional Technical Lead',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
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
                imageUrl: widget.item.image ?? '',
                errorWidget: (cxt, str, val) {
                  return SizedBox(
                    height: 64.0,
                    width: 64.0,
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
                height: 68.0,
                width: 68.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name ?? '',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _isMore = !_isMore;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Text(
                          _isMore ? 'Less' : 'More',
                          style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                    ],
                  ),
                  for (int i = 0;
                      i <
                          (_isMore
                              ? (widget.item.jobs ?? []).length
                              : (widget.item.jobs ?? []).length > 2
                                  ? 2
                                  : (widget.item.jobs ?? []).length);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\u25CF  ',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: (widget.item.jobs ?? [])[i].jobTittle ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (cxt) => JobDetailView(
                                        job: (widget.item.jobs ?? [])[i],
                                      ),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
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

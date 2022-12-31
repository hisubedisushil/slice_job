import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';
import 'package:slice_job/helpers/util/util.dart';

class FeaturedJobListItem extends StatefulWidget {
  final Company company;

  const FeaturedJobListItem({Key? key, required this.company})
      : super(key: key);

  @override
  State<FeaturedJobListItem> createState() => _FeaturedJobListItemState();
}

class _FeaturedJobListItemState extends State<FeaturedJobListItem> {
  bool _isMore = false;

  @override
  Widget build(BuildContext context) {
    final company = widget.company;
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: company.logo ?? '',
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
                height: 80.w,
                width: 80.w,
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
                          company.name ?? 'Company name',
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
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          _isMore ? 'Less' : 'More',
                          style: TextStyle(
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  ...company.jobs.take(2).map((e) {
                    return Padding(
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
                              text: e.jobTittle,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(
                                    RoutePaths.jobDetailRoute.routeName,
                                    extra: e,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedJobListShimmerItem extends StatelessWidget {
  const FeaturedJobListShimmerItem({Key? key}) : super(key: key);

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
                  for (int i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Row(
                        children: [
                          Text(
                            '\u25CF  ',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                          shimmerWidget(width: 150, height: 20),
                        ],
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

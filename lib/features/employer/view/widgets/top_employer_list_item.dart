import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';

class TopEmployerListItem extends StatelessWidget {
  final Company company;

  const TopEmployerListItem({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (ScreenUtil().screenWidth - 30.w) / 2;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: width.w,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width - 20.h,
              height: width - 20.h - 60.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: company.logo ?? '',
                  errorWidget: (cxt, str, val) {
                    return Center(
                      child: Icon(
                        Ionicons.alert_circle_outline,
                        color: AppColors.red,
                        size: 36.0,
                      ),
                    );
                  },
                  fit: BoxFit.contain,
                  width: width - 20.h,
                  height: width - 20.h - 60.h,
                ),
              ),
            ).pXY(10.w, 10.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.w),
                    bottomRight: Radius.circular(10.w),
                  ),
                  color: AppColors.primary.withAlpha(200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        company.name ?? 'Undisclosed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ).pX(10.w),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopEmployerShimmerListItem extends StatelessWidget {
  const TopEmployerShimmerListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (ScreenUtil().screenWidth - 30.w) / 2;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: width.w,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width - 20.h,
              height: width - 20.h - 60.h,
              child: shimmerWidget(
                width: width - 20.h,
                height: width - 20.h - 60.h,
              ),
            ).pXY(10.w, 10.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.w),
                    bottomRight: Radius.circular(10.w),
                  ),
                  color: AppColors.primary.withAlpha(200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: shimmerWidget(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.w),
                          bottomRight: Radius.circular(10.w),
                        ),
                        height: 60.h,
                        width: width - 20.h - 60.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

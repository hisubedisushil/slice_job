import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/shimmer_util.dart';
import 'package:slice_job/helpers/util/util.dart';

class BlogListItemWidget extends StatelessWidget {
  final Blog blog;

  const BlogListItemWidget({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: CachedNetworkImage(
                imageUrl: blog.image ?? '',
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 160.h,
              ),
            ),
            verticalSpacer(5.h),
            Text(
              blog.title ?? '',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            Text(
              blog.subTitle ?? '',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(
              'Published On ${blog.addDate}',
              style: TextStyle(
                color: AppColors.red,
                fontSize: 14.sp,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  context.pushNamed(
                    blogDetailRoute,
                    extra: blog,
                  );
                },
                color: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                elevation: 0.0,
                child: Text(
                  'Full Story',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogListShimmerItemWidget extends StatelessWidget {
  const BlogListShimmerItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 160.h,
              color: Colors.white,
              child: shimmerWidget(width: double.infinity, height: 160.h),
            ),
            verticalSpacer(5.h),
            shimmerWidget(height: 30.h, width: 200.w),
            verticalSpacer(2.h),
            shimmerWidget(height: 20.h, width: 100.w),
            verticalSpacer(2.h),
            shimmerWidget(height: 15.h, width: 75.w),
            Align(
              alignment: Alignment.centerRight,
              child: shimmerWidget(width: 80.w, height: 30.h),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/blog_model.dart';
import '../views/blog_detail_view.dart';

class BlogListItem extends StatelessWidget {
  final BlogModel blog;

  const BlogListItem({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: blog.image ?? '',
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 160.0,
              ),
            ),
            const SizedBox(width: double.infinity, height: 5.0),
            Text(
              blog.title ?? '',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              blog.subTitle ?? '',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              'Published On ${blog.addDate}',
              style: TextStyle(
                color: AppColors.red,
                fontSize: 14.0,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlogDetailView(blog: blog),
                    ),
                  );
                },
                child: Text(
                  'Full Story',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.0,
                  ),
                ),
                color: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 0.0,
              ),
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Solution Architect-Executive',
            //         style: TextStyle(
            //           color: AppColors.primary,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 18.0,
            //         ),
            //       ),
            //       const SizedBox(height: 2.5),
            //       Row(
            //         children: [
            //           Icon(
            //             Ionicons.business_outline,
            //             size: 18.0,
            //             color: AppColors.black,
            //           ),
            //           const SizedBox(width: 5.0),
            //           Text(
            //             'Worldlink Communications',
            //             style: TextStyle(
            //               color: AppColors.black,
            //               fontSize: 14.0,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 2.5),
            //       Row(
            //         children: [
            //           Icon(
            //             Ionicons.calendar_outline,
            //             size: 18.0,
            //             color: AppColors.black,
            //           ),
            //           const SizedBox(width: 5.0),
            //           Text(
            //             '2 days ago',
            //             style: TextStyle(
            //               color: AppColors.black,
            //               fontSize: 14.0,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

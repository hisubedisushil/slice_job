import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/features/blogs/views/blogs_screen.dart';
import 'package:slice_job/features/job_category/widgets/featured_job_category_shimmer_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';

class BlogCategoryListWidget extends ConsumerWidget {
  const BlogCategoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch<BaseState>(blogCategoryRef).maybeWhen(
      orElse: () {
        return Container(
          color: Colors.amber,
        );
      },
      loading: () {
        return const FeaturedJobCategoryShimmerWidget();
      },
      success: (data, extraData) {
        final response = data as List<BlogCategory>;
        return SizedBox(
          height: 32.0,
          child: ListView.separated(
            itemBuilder: (cxt, index) {
              final category = response[index];
              return ActionChip(
                label: Text(
                  category.catName ?? '',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  context.pushNamed(
                    blogCategoryRoute,
                    extra: category,
                  );
                },
                backgroundColor: AppColors.primary,
              );
            },
            separatorBuilder: (cxt, index) {
              return const SizedBox(width: 5.0);
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            itemCount: response.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/job_category/widgets/featured_job_category_shimmer_widget.dart';
import 'package:slice_job/features/jobs/views/job_search_screen.dart';

class JobCategoryListWidget extends ConsumerWidget {
  const JobCategoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch<BaseState>(jobCategoryRef).maybeWhen(
      orElse: () {
        return Container(
          color: Colors.amber,
        );
      },
      loading: () {
        return const FeaturedJobCategoryShimmerWidget();
      },
      success: (data, extraData) {
        final response = data as List<JobCategory>;
        return SizedBox(
          height: 32.0,
          child: ListView.separated(
            itemBuilder: (cxt, index) {
              final jobCategory = response[index];
              return ActionChip(
                label: Text(
                  jobCategory.name,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                onPressed: () {
                  context.pushNamed(
                    RoutePaths.jobCategoryScreenRoute.routeName,
                    extra: jobCategory,
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

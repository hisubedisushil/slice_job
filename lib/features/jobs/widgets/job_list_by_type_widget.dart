import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/jobs/widgets/featured_job_list_item.dart';
import 'package:slice_job/features/jobs/widgets/recent_job_list_item.dart';
import 'package:slice_job/helpers/enums/job_enums.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';

class JobListByTypeWidget extends ConsumerWidget {
  const JobListByTypeWidget({
    super.key,
    required this.provider,
    required this.type,
  });

  final AutoDisposeStateNotifierProvider<JobProvider, BaseState> provider;
  final JobTypeEnum type;

  SliverList makeDelegate(dynamic data) {
    if (type == JobTypeEnum.featured) {
      final jobsData = data as List<Company>;

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final company = jobsData[index];
            return FeaturedJobListItem(
              company: company,
            ).pXY(10.h, 5.h);
          },
          childCount: data.length,
        ),
      );
    } else {
      final jobsData = data as List<Job>;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final job = jobsData[index];
            return RecentJobListItem(
              job: job,
            ).pXY(10.h, 5.h);
          },
          childCount: data.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).maybeWhen(
      loading: () {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return type == JobTypeEnum.featured
                  ? const FeaturedJobListShimmerItem().pXY(10.h, 10.h)
                  : const RecentJobListShimmerItem().pXY(10.h, 10.h);
            },
            childCount: 2,
          ),
        );
      },
      success: (data, extraData) {
        return makeDelegate(data);
      },
      error: (failure) {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.red,
          ),
        );
      },
      orElse: () {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.amber,
          ),
        );
      },
    );
  }
}

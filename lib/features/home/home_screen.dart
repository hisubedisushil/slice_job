import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/features/employer/provider/employer_provider.dart';
import 'package:slice_job/features/employer/view/top_employer_list_widget.dart';
import 'package:slice_job/features/job_category/provider/job_category_provider.dart';
import 'package:slice_job/features/job_category/widgets/featured_job_category_list_widget.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/jobs/views/job_list_by_type_widget.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/helpers/enums/job_enums.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/widgets/header_widget.dart';

final featuredJobCategoryRef =
    StateNotifierProvider.autoDispose<JobCategoryProvider, BaseState>((ref) {
  return JobCategoryProvider(ref: ref);
});

final featuredJobsRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

final recentJobsRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

final topEmployerRef =
    StateNotifierProvider.autoDispose<EmployerProvider, BaseState>((ref) {
  return EmployerProvider(ref: ref);
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(featuredJobCategoryRef.notifier).getFeaturedJobCategories();
      ref.read(featuredJobsRef.notifier).getFeaturedJobs();
      ref.read(recentJobsRef.notifier).getRecentJobs();
      ref.read(topEmployerRef.notifier).getTopEmployers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.white,
            floating: true,
            pinned: false,
            snap: true,
            title: const HeaderWidget(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(87.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(24.0),
                          ),
                          color: AppColors.primary.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(5.5),
                            child: Icon(
                              Ionicons.search_outline,
                              color: AppColors.primary,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(navBarController.notifier)
                                  .setSelectedIndex(1);
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(24.0),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  fillColor: AppColors.primary.withOpacity(0.2),
                                  hintText: 'Search jobs here...',
                                  hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  filled: true,
                                  isDense: true,
                                  enabled: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const FeaturedJobCategoryListWidget(),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),

          // body begins here
          SliverPersistentHeader(
            delegate: Delegate('Featured Jobs'),
          ),
          JobListByTypeWidget(
            provider: featuredJobsRef,
            type: JobType.featured,
          ),
          SliverPersistentHeader(
            delegate: Delegate('Recent Jobs'),
          ),
          JobListByTypeWidget(
            provider: recentJobsRef,
            type: JobType.recent,
          ),
          SliverPersistentHeader(
            delegate: Delegate('Top Employers'),
          ),
          const TopEmployerListWidget(),
        ],
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final String _title;

  Delegate(this._title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.h,
      alignment: Alignment.centerLeft,
      color: AppColors.primary,
      child: Text(
        _title,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ).pX(10.w),
    );
  }

  @override
  double get maxExtent => 50.h;

  @override
  double get minExtent => 50.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

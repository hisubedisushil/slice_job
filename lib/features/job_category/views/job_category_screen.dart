import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/job_category/provider/job_by_category_provider.dart';
import 'package:slice_job/features/jobs/widgets/recent_job_list_item.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

final searchJobByCategoryRef =
    StateNotifierProvider.autoDispose<JobByCategoryProvider, BaseState>((ref) {
  return JobByCategoryProvider(ref: ref);
});

class JobCategoryScreen extends ConsumerStatefulWidget {
  final JobCategory jobCategory;

  const JobCategoryScreen({
    Key? key,
    required this.jobCategory,
  }) : super(key: key);

  @override
  ConsumerState<JobCategoryScreen> createState() => _JobCategoryScreenState();
}

class _JobCategoryScreenState extends ConsumerState<JobCategoryScreen> {
  late final JobCategory jobCategory;
  final PagingController<int, Job> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    super.initState();
    jobCategory = widget.jobCategory;
    _pagingControllerInit();
  }

  void _pagingControllerInit() {
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        ref.read(searchJobByCategoryRef.notifier).getJobsByCategory(
              jobCategoryId: widget.jobCategory.id,
              page: pageKey,
            );
      });
    });
  }

  void _updateData(List<Job> newJobs, int currentPage) {
    final isLastPage = newJobs.length < 18;
    if (isLastPage) {
      _pagingController.appendLastPage(newJobs);
    } else {
      _pagingController.appendPage(newJobs, currentPage + 1);
    }
  }

  Future<void> _onRefresh() {
    return Future.sync(
      () => _pagingController.refresh(),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(searchJobByCategoryRef, (previous, next) {
      if (next is BaseSuccess) {
        final paginatedData = next.data as BaseResponsePaginated<List<Job>>;
        final data = paginatedData.data;
        final currentPage = int.parse(paginatedData.page);
        log('itemCount: ${data.length}');
        _updateData(data, currentPage);
      }
    });
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            jobCategory.name,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: PagedListView<int, Job>.separated(
            padding: EdgeInsets.all(10.w),
            pagingController: _pagingController,
            separatorBuilder: (context, index) => verticalSpacer(10.h),
            builderDelegate: PagedChildBuilderDelegate<Job>(
              itemBuilder: (context, item, index) {
                return RecentJobListItem(
                  job: item,
                );
              },
              firstPageProgressIndicatorBuilder: (context) {
                return Column(
                  children: [
                    // SizedBox(
                    //   width: 25.w,
                    //   height: 25.w,
                    //   child: const CircularProgressIndicator(),
                    // ).pY(65.h),
                    const RecentJobListShimmerItem(),
                    verticalSpacer(10.h),
                    const RecentJobListShimmerItem(),
                    verticalSpacer(10.h),
                    const RecentJobListShimmerItem(),
                  ],
                );
              },
              noMoreItemsIndicatorBuilder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'List Completed',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    horizontalSpacer(10.w),
                    Icon(
                      Ionicons.checkmark_done_circle_outline,
                      size: 30.w,
                      color: AppColors.primary,
                    ),
                  ],
                ).pY(10.h);
              },
            ),
          ),
        ),
      ),
    );
  }
}

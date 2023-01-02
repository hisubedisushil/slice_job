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
import 'package:slice_job/core/widgets/home_screen_header.dart';
import 'package:slice_job/core/widgets/paginated_screen_error_widgets.dart';
import 'package:slice_job/features/job_category/provider/job_category_provider.dart';
import 'package:slice_job/features/jobs/models/job_search.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/jobs/widgets/job_category_list_widget.dart';
import 'package:slice_job/features/jobs/widgets/recent_job_list_item.dart';
import 'package:slice_job/features/jobs/widgets/search_filter_sheet.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

final jobSearchRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

final jobCategoryRef =
    StateNotifierProvider.autoDispose<JobCategoryProvider, BaseState>((ref) {
  return JobCategoryProvider(ref: ref);
});

class JobSearchScreen extends ConsumerStatefulWidget {
  const JobSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends ConsumerState<JobSearchScreen> {
  final PagingController<int, Job> _pagingController =
      PagingController(firstPageKey: 1);
  final searchData = ValueNotifier<JobSearch>(const JobSearch());
  final searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pagingControllerInit();
    _getBlogCategory();
  }

  void _getBlogCategory() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(jobCategoryRef.notifier).getJobCategories();
    });
  }

  void _pagingControllerInit() {
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        ref.read(jobSearchRef.notifier).searchJobs(
              page: pageKey,
              search: searchData.value,
            );
      });
    });
  }

  void _updateData(List<Job> freshJobs, int currentPage) {
    final isLastPage = freshJobs.length < 18;
    if (isLastPage) {
      _pagingController.appendLastPage(freshJobs);
    } else {
      _pagingController.appendPage(freshJobs, currentPage + 1);
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
    ref.listen(jobSearchRef, (previous, next) {
      if (next is BaseSuccess) {
        final paginatedData = next.data as BaseResponsePaginated<List<Job>>;
        final data = paginatedData.data;
        final currentPage = int.parse(paginatedData.page);
        log('itemCount: ${data.length}');
        _updateData(data, currentPage);
      }
      if (next is BaseError) {
        final paginatedData = next.data;
        final currentPage = int.parse(paginatedData.page);
        _pagingController.error = 'first Page error';
        log('error:');
      }
    });
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.white,
            floating: true,
            pinned: false,
            snap: false,
            title: const HomeScreenHeaderWidget(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(87.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 15.0),
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
                          child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(24.0),
                            ),
                            child: TextFormField(
                              controller: searchTextController,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                fillColor: AppColors.primary.withOpacity(0.2),
                                hintText: 'Search jobs here ...',
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                filled: true,
                                isDense: true,
                              ),
                              onChanged: (value) {
                                // _initSearch();
                              },
                            ),
                          ),
                        ),
                        ValueListenableBuilder<JobSearch>(
                          valueListenable: searchData,
                          builder: (context, value, child) {
                            final filterCount = value.filterCount();
                            return IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                  ),
                                  builder: (cxt) => FractionallySizedBox(
                                    heightFactor: 0.75,
                                    child: SearchFilterSheet(
                                      filterData: searchData.value,
                                      onFilter: (filteredSearchData) {
                                        Navigator.pop(context);
                                        searchData.value = filteredSearchData;
                                        _onRefresh();
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  if (filterCount > 0)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.red,
                                        radius: 7.0,
                                        child: Text(
                                          '$filterCount',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  verticalSpacer(10.h),
                  const JobCategoryListWidget(),
                  verticalSpacer(10.h),
                ],
              ),
            ),
          ),
          PagedSliverList.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Job>(
              itemBuilder: (context, item, index) {
                return RecentJobListItem(
                  job: item,
                ).pX(10.w).pT(index == 0 ? 10.h : 0);
              },
              firstPageProgressIndicatorBuilder: (context) {
                return Column(
                  children: [
                    verticalSpacer(10.h),
                    const RecentJobListShimmerItem(),
                    verticalSpacer(10.h),
                    const RecentJobListShimmerItem(),
                    verticalSpacer(10.h),
                    const RecentJobListShimmerItem(),
                  ],
                ).pX(10.h);
              },
              firstPageErrorIndicatorBuilder: (context) {
                return const FirstPageError(
                  message: 'Error Fetching jobs at this time!',
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return const NewPageError(
                  message: 'Error Fetching new jobs at this time!',
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
            separatorBuilder: (context, index) {
              return verticalSpacer(10.h);
            },
          ),
        ],
      ),
    );
  }
}

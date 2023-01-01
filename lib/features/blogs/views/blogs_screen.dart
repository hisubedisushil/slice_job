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
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/core/widgets/home_screen_header.dart';
import 'package:slice_job/features/blogs/provider/blogs_provider.dart';
import 'package:slice_job/features/blogs/widgets/blog_category_list_widget.dart';
import 'package:slice_job/features/blogs/widgets/blog_list_item_widget.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

final blogsRef =
    StateNotifierProvider.autoDispose<BlogsProvider, BaseState>((ref) {
  return BlogsProvider(ref: ref);
});

final blogCategoryRef =
    StateNotifierProvider.autoDispose<BlogsProvider, BaseState>((ref) {
  return BlogsProvider(ref: ref);
});

class BlogsScreen extends ConsumerStatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends ConsumerState<BlogsScreen> {
  final PagingController<int, Blog> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    super.initState();
    _pagingControllerInit();
    _getBlogCategory();
  }

  void _getBlogCategory() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(blogCategoryRef.notifier).getBlogCategory();
    });
  }

  void _pagingControllerInit() {
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        ref.read(blogsRef.notifier).getAllBlogs(
              page: pageKey,
            );
      });
    });
  }

  void _updateData(List<Blog> newBlogs, int currentPage) {
    final isLastPage = newBlogs.length < 18;
    if (isLastPage) {
      _pagingController.appendLastPage(newBlogs);
    } else {
      _pagingController.appendPage(newBlogs, currentPage + 1);
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
    ref.listen(blogsRef, (previous, next) {
      if (next is BaseSuccess) {
        final paginatedData = next.data as BaseResponsePaginated<List<Blog>>;
        final data = paginatedData.data;
        final currentPage = int.parse(paginatedData.page);
        log('itemCount: ${data.length}');
        _updateData(data, currentPage);
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
              preferredSize: const Size.fromHeight(76.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'View Blogs by Popular Category',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  verticalSpacer(10.h),
                  const BlogCategoryListWidget(),
                  verticalSpacer(10.h),
                ],
              ),
            ),
          ),
          PagedSliverList.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Blog>(
              itemBuilder: (context, item, index) {
                return BlogListItemWidget(
                  blog: item,
                ).pX(10.w).pT(index == 0 ? 10.h : 0);
              },
              firstPageProgressIndicatorBuilder: (context) {
                return Column(
                  children: [
                    verticalSpacer(10.h),
                    const BlogListShimmerItemWidget(),
                    verticalSpacer(10.h),
                    const BlogListShimmerItemWidget(),
                    verticalSpacer(10.h),
                    const BlogListShimmerItemWidget(),
                  ],
                ).pX(10.h);
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

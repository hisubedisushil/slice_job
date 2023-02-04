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
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/core/widgets/paginated_screen_error_widgets.dart';
import 'package:slice_job/features/blogs/provider/blogs_provider.dart';
import 'package:slice_job/features/blogs/widgets/blog_list_item_widget.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

final blogCategoriesRef =
    StateNotifierProvider.autoDispose<BlogsProvider, BaseState>((ref) {
  return BlogsProvider(ref: ref);
});

class BlogCategoryScreen extends ConsumerStatefulWidget {
  final BlogCategory blogCategory;

  const BlogCategoryScreen({
    Key? key,
    required this.blogCategory,
  }) : super(key: key);

  @override
  ConsumerState<BlogCategoryScreen> createState() => _BlogCategoryScreenState();
}

class _BlogCategoryScreenState extends ConsumerState<BlogCategoryScreen> {
  late final BlogCategory blogCategory;
  final PagingController<int, Blog> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    super.initState();
    blogCategory = widget.blogCategory;
    _pagingControllerInit();
  }

  void _pagingControllerInit() {
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        ref.read(blogCategoriesRef.notifier).getBlogsByCategory(
              blogCategoryId: widget.blogCategory.id,
              page: pageKey,
            );
      });
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.firstPageError) {}
    });
  }

  void _updateData(List<Blog> freshBlogs, int currentPage) {
    final isLastPage = freshBlogs.length < 18;
    if (isLastPage) {
      _pagingController.appendLastPage(freshBlogs);
    } else {
      _pagingController.appendPage(freshBlogs, currentPage + 1);
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
    ref.listen(blogCategoriesRef, (previous, next) {
      if (next is BaseSuccess) {
        final paginatedData = next.data as BaseResponsePaginated<List<Blog>>;
        final data = paginatedData.data;
        final currentPage = int.parse(paginatedData.page);
        log('itemCount: ${data.length}');
        _updateData(data, currentPage);
      }
      if (next is BaseError) {
        _pagingController.error = 'first Page error';
        log('error:');
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            blogCategory.catName ?? '',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: PagedListView<int, Blog>.separated(
            padding: EdgeInsets.all(10.w),
            pagingController: _pagingController,
            separatorBuilder: (context, index) => verticalSpacer(10.h),
            builderDelegate: PagedChildBuilderDelegate<Blog>(
              firstPageErrorIndicatorBuilder: (context) {
                return const FirstPageError(
                  message: 'Error Fetching blog by category at this time!',
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return const NewPageError(
                  message: 'Error Fetching new blog items at this time!',
                );
              },
              itemBuilder: (context, item, index) {
                return BlogListItemWidget(
                  blog: item,
                );
              },
              firstPageProgressIndicatorBuilder: (context) {
                return Column(
                  children: [
                    const BlogListShimmerItemWidget(),
                    verticalSpacer(10.h),
                    const BlogListShimmerItemWidget(),
                    verticalSpacer(10.h),
                    const BlogListShimmerItemWidget(),
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

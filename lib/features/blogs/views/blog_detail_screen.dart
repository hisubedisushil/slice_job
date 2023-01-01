import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/features/blogs/provider/blogs_provider.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

final blogDetailRef =
    StateNotifierProvider.autoDispose<BlogsProvider, BaseState>((ref) {
  return BlogsProvider(ref: ref);
});

class BlogDetailScreen extends ConsumerStatefulWidget {
  final Blog blog;

  const BlogDetailScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  ConsumerState<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends ConsumerState<BlogDetailScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(blogDetailRef.notifier).getBlogDetail(blogId: widget.blog.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title ?? '',
              ),
              ref.watch(blogDetailRef).maybeWhen(
                success: (data, extraData) {
                  final blogDetail = data as Blog;
                  return Text(
                    'Posted on ${blogDetail.addDate ?? ''}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  );
                },
                orElse: () {
                  return Text(
                    'Posted on ${blog.addDate ?? ''}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  );
                },
              ),
            ],
          ),
          actions: ref.watch(blogDetailRef).maybeWhen(
            success: (data, extraData) {
              final blogDetail = data as Blog;
              return [
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${blogDetail.title}\n'
                      '${blogDetail.link}',
                      subject: blogDetail.title,
                    );
                  },
                  icon: Icon(
                    Ionicons.share_outline,
                    color: AppColors.white,
                  ),
                ),
              ];
            },
            orElse: () {
              return null;
            },
          ),
        ),
        body: ref.watch(blogDetailRef).maybeWhen(
          loading: () {
            return SizedBox(
              width: double.infinity,
              height: 100.h,
              child: Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          },
          success: (data, extraData) {
            final blogDetail = data as Blog;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 20.0,
                left: 20.0,
                bottom: 80.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: blogDetail.image ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    blogDetail.title ?? '',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  HtmlWidget(
                    blogDetail.detailDesc ?? '',
                    onTapUrl: (url) async {
                      return openUrl(url);
                    },
                  ),
                ],
              ),
            );
          },
          error: (failure) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Oops! Something went wrong. '
                  'Unable to load blog. '
                  'Please try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.grey,
                  ),
                ),
                MaterialButton(
                  // onPressed: _loadBlog,
                  onPressed: () {
                    //
                  },
                  elevation: 0.0,
                  color: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Reload',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ).pad(20.w);
          },
          orElse: () {
            return Container(
              color: Colors.amber,
            );
          },
        ),
      ),
    );
  }
}

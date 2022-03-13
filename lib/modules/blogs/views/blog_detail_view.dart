import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/blog_controller.dart';
import '../../../models/blog_model.dart';

class BlogDetailView extends StatefulWidget {
  final BlogModel blog;

  const BlogDetailView({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  bool _loading = true;
  BlogModel? _blog;

  @override
  void initState() {
    super.initState();
    _loadBlog();
  }

  _loadBlog() async {
    if (_blog == null && !_loading) {
      _loading = true;
      setState(() {});
    }
    _blog = await context
        .read<BlogController>()
        .getBlogDetail(blogId: widget.blog.id ?? '');
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Material(
        color: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          appBar: AppBar(
            title: Text(widget.blog.title ?? ''),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    if (_blog == null) {
      return Material(
        color: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          appBar: AppBar(
            title: Text(widget.blog.title ?? ''),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                    onPressed: _loadBlog,
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
              ),
            ),
          ),
        ),
      );
    }
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_blog?.title ?? ''),
              Text(
                'Category: ${_blog?.categoryName ?? ''}',
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                imageUrl: _blog?.image ?? '',
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20.0),
              Text(
                _blog?.title ?? '',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 10.0),
              HtmlWidget(
                _blog?.detailDesc ?? '',
                onTapUrl: (url) async {
                  launch(url);
                  return await canLaunch(url);
                },
                // textStyle: TextStyle(
                //   color: AppColors.black,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

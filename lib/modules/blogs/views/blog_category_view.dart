import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/blog_controller.dart';
import '../../../models/blog_category_model.dart';
import '../../../models/blog_model.dart';
import '../widgets/blog_list_item.dart';

class BlogCategoryView extends StatefulWidget {
  final BlogCategoryModel model;

  const BlogCategoryView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<BlogCategoryView> createState() => _BlogCategoryViewState();
}

class _BlogCategoryViewState extends State<BlogCategoryView> {
  @override
  void initState() {
    super.initState();
    _initSearch();
  }

  _initSearch() {
    _searching = true;
    if (mounted) {
      setState(() {});
    }
    _page = 1;
    _search();
    Timer(
      const Duration(seconds: 3),
      () {
        _searching = false;
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            widget.model.catName ?? '',
          ),
        ),
        body: Column(
          children: [
            if (_searching)
              const SizedBox(
                height: 160.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!_searching)
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      log(scrollInfo.metrics.pixels.toString());
                      _page++;
                      _loadingMore = true;
                      if (mounted) {
                        setState(() {});
                      }
                      _search();
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemBuilder: (cxt, index) {
                      final blog = _searchedBlogs[index];
                      return BlogListItem(blog: blog);
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: _searchedBlogs.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
            if (_loadingMore)
              const SizedBox(
                height: 52.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<BlogModel> _searchedBlogs = [];
  bool _searching = false;
  bool _loadingMore = false;
  int _page = 1;

  _search() async {
    List<BlogModel> blogs = await context
        .read<BlogController>()
        .searchBlogsByCategory(page: _page, id: widget.model.id ?? '');
    if (_page == 1) {
      _searchedBlogs
        ..clear()
        ..addAll(blogs);
    } else {
      _searchedBlogs.addAll(blogs);
    }
    log(_searchedBlogs.length.toString());
    _loadingMore = false;
    if (mounted) {
      setState(() {});
    }
  }
}

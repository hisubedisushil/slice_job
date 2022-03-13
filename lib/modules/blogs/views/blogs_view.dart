import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/blog_controller.dart';
import '../../../controllers/general_controller.dart';
import '../../../widgets/header_widget.dart';
import '../widgets/blog_list_item.dart';
import 'blog_category_view.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogController = context.watch<BlogController>();
    final generalController = context.watch<GeneralController>();

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          log(scrollInfo.metrics.pixels.toString());
          blogController.getAllBlogs(init: false);
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => blogController.getAllBlogs(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.white,
              floating: true,
              pinned: false,
              snap: false,
              title: const HeaderWidget(),
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
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 32.0,
                      child: ListView.separated(
                        itemBuilder: (cxt, index) {
                          final category =
                              generalController.blogCategories[index];
                          return ActionChip(
                            label: Text(
                              category.catName ?? '',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (cxt) => BlogCategoryView(
                                    model: category,
                                  ),
                                ),
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
                        itemCount: generalController.blogCategories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10.0),
                ListView.separated(
                  itemBuilder: (cxt, index) {
                    final blog = blogController.allBlogs[index];
                    return BlogListItem(blog: blog);
                  },
                  separatorBuilder: (cxt, index) {
                    return const SizedBox(height: 10.0);
                  },
                  itemCount: blogController.allBlogs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  physics: const NeverScrollableScrollPhysics(),
                ),
                if (blogController.isMoreBlogs)
                  const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                const SizedBox(height: 60.0),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

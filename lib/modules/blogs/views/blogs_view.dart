import 'package:flutter/material.dart';

import '../widgets/blog_list_item.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (cxt, index) {
          return const BlogListItem();
        },
        separatorBuilder: (cxt, index) {
          return const SizedBox(height: 10.0);
        },
        itemCount: 10,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

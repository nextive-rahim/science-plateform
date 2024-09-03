import 'package:flutter/material.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';
import 'package:science_platform/src/feature/home/blogs/widgets/blog_card.dart';

class BlogListBuilder extends StatelessWidget {
  const BlogListBuilder({
    super.key,
    required this.blogList,
  });
  final List<BlogModel> blogList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          primary: true,
          itemBuilder: (context, index) {
            BlogModel blog = blogList[index];
            return BlogCard(
              blog: blog,
            );
          },
          itemCount: blogList.length,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';
import 'package:science_platform/src/feature/home/blogs/widgets/featured_blog_card.dart';

class FeaturedBlogListBuilder extends StatelessWidget {
  const FeaturedBlogListBuilder({
    super.key,
    required this.blogList,
  });
  final List<BlogModel> blogList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blogList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 253 / 215,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              BlogModel blog = blogList[index];
              return FeaturedBlogCard(
                blog: blog,
              );
            },
          ),
        ),
      ],
    );
  }
}

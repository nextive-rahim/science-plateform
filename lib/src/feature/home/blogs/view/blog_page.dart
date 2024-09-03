import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/widgets/shimmer_gradview_builder.dart';
import 'package:science_platform/src/core/widgets/shimmer_listview_builder.dart';
import 'package:science_platform/src/feature/home/blogs/controller/blog_view_controller.dart';
import 'package:science_platform/src/feature/home/blogs/widgets/blog_list_builder.dart';
import 'package:science_platform/src/feature/home/blogs/widgets/featured_blog_list_builder.dart';
import 'package:science_platform/src/widgets/pill_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends GetView<BlogViewController> {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(TextConstants.blog),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.featuredBlogs();
          controller.getBlogList();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: RefreshIndicator(
              onRefresh: () async {
                controller.featuredBlogs();
                controller.getBlogList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const PillTitle(title: 'পপুলার ব্লগসমূহ'),
                  Obx(
                    () {
                      if (controller.pageState == PageState.loading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 200,
                            child: ShimmerGridViewBuilder(
                              itemCount: 2,
                              childAspectRatio: 253 / 275,
                            ),
                          ),
                        );
                      }
                      return FeaturedBlogListBuilder(
                        blogList: controller.categories,
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      const PillTitle(title: 'সকল ব্লগ'),
                      Obx(
                        () {
                          if (controller.blogListState == PageState.loading) {
                            return const ShimmerListViewBuilder();
                          }
                          return BlogListBuilder(blogList: controller.blogList);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

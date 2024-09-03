import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';

class FeaturedBlogCard extends StatelessWidget {
  const FeaturedBlogCard({
    super.key,
    required this.blog,
  });
  final BlogModel blog;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            Routes.blogDetailsPage,
            arguments: blog.slug,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightBlack10,
              ),
            ),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: blog.image?.link ?? noImageFoundURL,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) {
                    return Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.title ?? '',
                          maxLines: 2,
                          style: AppTextStyle.bold14.copyWith(
                              height: 18 / 14, overflow: TextOverflow.ellipsis),
                        ),
                        _buildAuthor(blog),
                      ],
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

  Widget _buildAuthor(BlogModel blog) {
    return blog.authorName != null
        ? Row(
            children: [
              SizedBox(
                height: 28,
                width: 28,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    blog.authorImage!,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Writer',
                      style: AppTextStyle.semibold12.copyWith(
                        fontSize: 10,
                        color: AppColors.lightBlack60,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            blog.authorName ?? 'Unknown',
                            maxLines: 1,
                            style: AppTextStyle.semibold12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        : const SizedBox();
  }
}

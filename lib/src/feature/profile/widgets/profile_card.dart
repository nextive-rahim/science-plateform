import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/routes/app_pages.dart';
import 'package:science_platform/src/utils/app_constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.onTap,
    required this.user,
  });
  final Function()? onTap;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 241,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TODO: Update the image when the api is ready
            Container(
              height: 93,
              width: 93,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightBlack10,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: user.image?.link == null
                      ? CachedNetworkImage(
                          imageUrl: noProfileFoundURL,
                          cacheKey: noProfileFoundURL,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: user.image!.link!,
                          cacheKey: user.image!.link!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 20 / 17,
                        ),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: RichText(
                          text: TextSpan(
                            text: 'ID: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: user.id.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4866D7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.institution ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          height: 15 / 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.profileInfo);
                    },
                    child: Container(
                      height: 26,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFF5F6FF)),
                      child: const Center(
                        child: Text(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlack60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

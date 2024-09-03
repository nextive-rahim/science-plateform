import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/home/support/controller/support_view_controller.dart';
import 'package:science_platform/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? info;
  final String? btnText;
  final Function()? onBtnTap;
  final String? details;
  final List<Widget>? footerItems;
  final bool isHotline;
  final String? info2;
  final String? info3;
  final String? info4;

  const SupportInfoItem({
    super.key,
    required this.icon,
    required this.title,
    this.info,
    this.info2,
    this.info3,
    this.info4,
    this.btnText,
    this.onBtnTap,
    this.details,
    this.footerItems,
    this.isHotline = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportViewController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: AppColors.primary,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: AppTextStyle.semibold14.copyWith(
                  height: 0,
                ),
              ),
              const Spacer(),
              isHotline
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => controller.hotlineSupport(),
                          child: Text(
                            info ?? '',
                            style: AppTextStyle.semibold14.copyWith(
                              shadows: [
                                const Shadow(
                                  color: AppColors.primary,
                                  offset: Offset(0, -3),
                                )
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              decorationThickness: 2,
                              fontSize: 12,
                              height: 18 / 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => controller.hotlineSupport2(),
                          child: Text(
                            info2 ?? '',
                            style: AppTextStyle.semibold14.copyWith(
                              shadows: [
                                const Shadow(
                                  color: AppColors.primary,
                                  offset: Offset(0, -3),
                                )
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              decorationThickness: 2,
                              fontSize: 12,
                              height: 18 / 12,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // GestureDetector(
                        //   onTap: () => controller.hotlineSupport3(),
                        //   child: Text(
                        //     info3 ?? '',
                        //     style: AppTextStyle.semibold14.copyWith(
                        //       shadows: [
                        //         const Shadow(
                        //           color: AppColors.primary,
                        //           offset: Offset(0, -3),
                        //         )
                        //       ],
                        //       color: Colors.transparent,
                        //       decoration: TextDecoration.underline,
                        //       decorationColor: AppColors.primary,
                        //       decorationThickness: 2,
                        //       fontSize: 12,
                        //       height: 18 / 12,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // GestureDetector(
                        //   onTap: () => controller.hotlineSupport4(),
                        //   child: Text(
                        //     info4 ?? '',
                        //     style: AppTextStyle.semibold14.copyWith(
                        //       shadows: [
                        //         const Shadow(
                        //           color: AppColors.primary,
                        //           offset: Offset(0, -3),
                        //         )
                        //       ],
                        //       color: Colors.transparent,
                        //       decoration: TextDecoration.underline,
                        //       decorationColor: AppColors.primary,
                        //       decorationThickness: 2,
                        //       fontSize: 12,
                        //       height: 18 / 12,
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  : Text(
                      info ?? '',
                      style: AppTextStyle.semibold14.copyWith(
                        color: AppColors.primary,
                        fontSize: 12,
                        height: 18 / 12,
                      ),
                    ),
            ],
          ),
          details != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          details ?? '',
                          style: AppTextStyle.medium12.copyWith(
                            height: 18 / 12,
                            color: AppColors.lightBlack80,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          btnText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundedButton(
                        title: btnText ?? '',
                        onPressed: onBtnTap,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (footerItems != null && footerItems!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: footerItems ?? [],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

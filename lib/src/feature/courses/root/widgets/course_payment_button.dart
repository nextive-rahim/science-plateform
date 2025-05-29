part of '../view/course_details_page.dart';

class _CoursePaymentButton extends StatelessWidget {
  const _CoursePaymentButton({
    required this.controller,
  });

  final CourseDetailsViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (controller.coursePrice.value == 0)
            ? const Offstage()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                      left: 5,
                      right: 5,
                    ),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.togglePromoCodeField();
                          },
                          child: Text(
                            TextConstants.promoCode,
                            style: AppTextStyle.bold16.copyWith(
                              color: AppColors.primary,
                              height: 24 / 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        _buildPrice()
                      ],
                    ),
                  ),

                  /// Promo Code TextField
                  Obx(
                    () {
                      if (controller.isPromoCodeFieldVisible.value == false) {
                        return const Offstage();
                      }

                      return Container(
                        height: 50,
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: controller.appliedCoupon.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: controller
                                                    .appliedCoupon.value,
                                                style: AppTextStyle.bold16
                                                    .copyWith(
                                                  color: AppColors.black,
                                                  height: 0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' is applied. ',
                                                style: AppTextStyle.medium16
                                                    .copyWith(
                                                  color: AppColors.lightBlack80,
                                                  height: 0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Discount: ',
                                                style: AppTextStyle.bold16
                                                    .copyWith(
                                                  color: AppColors.black,
                                                  height: 0,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '৳${controller.couponDiscount}',
                                                style: AppTextStyle.bold16
                                                    .copyWith(
                                                  color: AppColors.lightGreen,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            controller.cancelCoupon();
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: AppColors.red,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: OutlinedInputField(
                                        height: 40,
                                        showBorder: false,
                                        bottomPadding: 0,
                                        controller:
                                            controller.promoCodeController,
                                        hintText: 'কুপন কোড দিন',
                                      ),
                                    ),
                                    Obx(
                                      () => RoundedButton(
                                        title: 'সাবমিট',
                                        backgroundColor: AppColors.primary,
                                        radius: 5,
                                        onPressed: controller.couponState ==
                                                PageState.loading
                                            ? () {}
                                            : () {
                                                controller.applyCoupon();
                                              },
                                        child: controller.couponState ==
                                                PageState.loading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: AppColors.white,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
        SizedBox(
          height: 45,
          child: Obx(
            () => PrimaryButton(
              onTap: _onPaymentButtonTapped,
              backgroundColor: (controller.courseDetails?.price == null)
                  ? AppColors.lightGrey
                  : null,
              isLoading: controller.isLoading ||
                  (controller.purchaseController?.isLoading ?? false),
              widget: Text(
                (controller.courseDetails?.price == null)
                    ? 'Not Available'
                    : controller.coursePrice.value == 0
                        ? TextConstants.enrollForFree
                        : TextConstants.enrollNow,
                style: AppTextStyle.semiBold16
                    .copyWith(fontSize: 14, height: 0, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onPaymentButtonTapped() async {
    if (controller.courseDetails?.price == null) {
      return;
    }

    if (controller.courseDetails!.isFreeCourse ||
        controller.coursePrice.value == 0) {
      Get.find<CoursePurchaseController>().enrollInFreeCourse();
    } else {
      Get.toNamed(Routes.checkout);
    }
  }

  Widget _buildPrice() {
    CourseModel course = controller.courseDetails!;

    if (course.price == null) {
      return const Text(
        'Not Available',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.primary,
        ),
      );
    }

    if ((course.price?.amount ?? 0) <= 0) {
      return const Text(
        'Free',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.primary,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            course.hasDiscount
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '৳${course.price?.amount}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: AppColors.lightBlack80,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  )
                : const SizedBox(),
            Obx(
              () => Text(
                '৳${controller.coursePrice.value}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/controller/checkout_view_controller.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/order_model.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/widgets/manual_payment_section.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/feature/courses/purchase/widgets/checkout_info_type_item.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

part '../widgets/order_details.dart';
part '../widgets/order_summery.dart';

class CheckoutPage extends GetView<CheckoutViewController> {
  CheckoutPage({super.key}) {
    controller.setCourseModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextConstants.checkout,
          style: AppTextStyle.semibold18,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 100,
        ),
        child: Obx(() {
          if (controller.isLoading) {}
          if (controller.coursePurchaseController.orderDataModel == null) {
            return Column(
              children: [
                _OrderSummery(controller: controller),
                const SizedBox(height: 15),
                _buildDigitalPaymentSection(
                  controller.payableAmount,
                  controller.courseModel!,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _OrderDetails(
                  orderData:
                      controller.coursePurchaseController.orderDataModel!,
                ),
                const SizedBox(
                  height: 20,
                ),
                ManualPaymentContainer(
                    controller: controller.coursePurchaseController)
              ],
            );
          }
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 37,
          right: 5,
        ),
        child: Obx(
          () {
            if (controller.coursePurchaseController.orderDataModel == null) {
              return PrimaryButton(
                onTap: controller.coursePurchaseController.placeOrder,
                isLoading: controller.isLoading,
                widget: Text(
                  TextConstants.payNow,
                  style: AppTextStyle.bold16.copyWith(color: AppColors.white),
                ),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => PrimaryButton(
                        onTap: () {
                          // if (  controller.coursePurchaseController.selectedPaymentMethod ==
                          //     TextConstants.manualPayment) {
                          if (controller
                              .coursePurchaseController.hasPaymentData) {
                            Get.snackbar(
                              'Failed',
                              'Please add all the required fields!',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          controller.coursePurchaseController.placePaymentOrder(
                            controller.coursePurchaseController.orderDataModel,
                            controller.coursePurchaseController.formKey,
                          );
                        },
                        //  else {
                        //   Get.snackbar(
                        //     'Error!',
                        //     'Please select a payment method first!',
                        //     snackPosition: SnackPosition.BOTTOM,
                        //   );
                        // }
                        //  },
                        isLoading:
                            controller.coursePurchaseController.isLoading,
                        widget: Text(
                          TextConstants.submit,
                          style: AppTextStyle.bold16
                              .copyWith(color: AppColors.white),
                        ),
                      ))
                  // const Text(
                  //   'Select Payment Method',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     height: 27 / 16,
                  //     color: AppColors.lightBlack40,
                  //   ),
                  // ),
                  // const SizedBox(height: 15),
                  // AamarPayContainer(
                  //   isSandBox: false,
                  //   orderModel:
                  //       controller.coursePurchaseController.orderDataModel,
                  //   child: Obx(
                  //     () => AbsorbPointer(
                  //       absorbing: controller.isLoading,
                  //       child: Opacity(
                  //         opacity: controller.isLoading ? 0.5 : 1,
                  //         child: const PaymentMethodCard(
                  //           logo: Assets.aamarPayLogo,
                  //           isLoading: false,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDigitalPaymentSection(
    double coursePrice,
    CourseModel courseModel,
  ) {
    return Obx(
      () => controller.coursePurchaseController.groupValue.value !=
              controller.coursePurchaseController.impossibleItemLength
          ? Column(
              children: [
                _LabeledRadio(
                  label: '${TextConstants.fullPayment} ৳ $coursePrice',
                  coursePurchaseController: controller.coursePurchaseController,
                  value:
                      controller.coursePurchaseController.getFullPriceItemValue,
                  onChanged: (int newValue) {
                    controller.coursePurchaseController.groupValue.value =
                        newValue;
                    controller.coursePurchaseController.selectedInstalments
                        .clear();
                  },
                ),
                // Obx(
                //   () => coursePurchaseController.selectedInstalments.length !=
                //           coursePurchaseController.impossibleItemLength
                //       ? ListView.builder(
                //           shrinkWrap: true,
                //           physics: const NeverScrollableScrollPhysics(),
                //           itemCount: courseModel.instalments?.length,
                //           itemBuilder: (BuildContext context, int index) {
                //             Instalment instalment =
                //                 courseModel.instalments![index];

                //             return _LabeledCheckBox(
                //               label:
                //                   '${TextConstants.payInstalment} ${instalment.price!}',
                //               coursePurchaseController:
                //                   coursePurchaseController,
                //               value: index,
                //               instalment: instalment,
                //             );
                //           },
                //         )
                //       : const SizedBox(),
                // ),
              ],
            )
          : const SizedBox(),
    );
  }
}

class _LabeledRadio extends StatelessWidget {
  const _LabeledRadio({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.coursePurchaseController,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final CoursePurchaseController coursePurchaseController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (value != coursePurchaseController.groupValue.value) {
          onChanged(value);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.lightBlack20,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  fillColor: value != coursePurchaseController.groupValue.value
                      ? WidgetStateProperty.all(AppColors.lightBlack20)
                      : null,
                  activeColor: AppColors.primary,
                  groupValue: coursePurchaseController.groupValue.value,
                  value: value,
                  onChanged: (int? newValue) {
                    onChanged(newValue!);
                  },
                ),
                Text(
                  label,
                  style: AppTextStyle.medium14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledCheckBox extends StatefulWidget {
  const _LabeledCheckBox({
    required this.label,
    required this.value,
    required this.coursePurchaseController,
    this.instalment,
  });

  final String label;
  final int value;
  final CoursePurchaseController coursePurchaseController;
  final Instalment? instalment;

  @override
  State<_LabeledCheckBox> createState() => _LabeledCheckBoxState();
}

class _LabeledCheckBoxState extends State<_LabeledCheckBox> {
  bool checkIfTheInstalmentIsOpenToPurchase() {
    bool isOpenToPurchase = false;
    if (widget.instalment != null &&
        widget.instalment?.purchased == false &&
        widget.coursePurchaseController
            .checkIfPreviousInstalmentIsSelected(widget.instalment)) {
      isOpenToPurchase = true;
    } else {
      isOpenToPurchase = false;
    }
    return isOpenToPurchase;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checkIfTheInstalmentIsOpenToPurchase()) {
          widget.coursePurchaseController
              .addOrRemoveSelectedItem(widget.instalment);
          setState(() {});
        } else {
          widget.coursePurchaseController.selectedInstalments
              .remove(widget.instalment);
        }
        return;
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: (checkIfTheInstalmentIsOpenToPurchase())
              ? AppColors.white
              : AppColors.lightBlack10,
          border: Border.all(
            color: AppColors.lightBlack20,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.coursePurchaseController.selectedInstalments
                      .contains(widget.instalment),
                  fillColor: (checkIfTheInstalmentIsOpenToPurchase())
                      ? null
                      : WidgetStateProperty.all(AppColors.lightBlack20),
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    if (checkIfTheInstalmentIsOpenToPurchase()) {
                      widget.coursePurchaseController
                          .addOrRemoveSelectedItem(widget.instalment);
                      setState(() {});
                    }
                  },
                ),
                Text(
                  widget.label,
                  style: AppTextStyle.medium14,
                ),
              ],
            ),
            if (widget.instalment == null)
              const SizedBox()
            else
              (widget.instalment?.purchased == true)
                  ? Tooltip(
                      message: TextConstants.instalmentIsPaid,
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green.shade300,
                      ),
                    )
                  : (checkIfTheInstalmentIsOpenToPurchase() == false)
                      ? Tooltip(
                          message: TextConstants.instalmentIsNotAvailable,
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red.shade300,
                          ),
                        )
                      : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

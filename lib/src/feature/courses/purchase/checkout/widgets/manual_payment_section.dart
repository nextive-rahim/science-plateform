import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/controller/checkout_view_controller.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dropdown.dart';
import 'package:science_platform/src/widgets/common_video_player.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/pill_title.dart';

class ManualPaymentContainer extends StatefulWidget {
  const ManualPaymentContainer({
    super.key,
    required this.controller,
  });
  final CoursePurchaseController controller;
  @override
  State<ManualPaymentContainer> createState() => _ManualPaymentContainerState();
}

class _ManualPaymentContainerState extends State<ManualPaymentContainer> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const PillTitle(title: TextConstants.manualPaymentInstruction),
          // paymentInstructionViewController.instruction!.isNotEmpty
          //     ? HtmlWidget(
          //         paymentInstructionViewController.instruction!.first.value ??
          //             '')
          //     : const Offstage(),
          const SizedBox(height: 20),
          OutlinedInputField(
            controller: widget.controller.senderController,
            hintText: TextConstants.senderNumber,
            fillColor: AppColors.white,
            borderColor: AppColors.lightBlack20,
            showBorder: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: InputFieldValidator.phoneNumber(),
          ),
          OutlinedInputField(
            controller: widget.controller.receiverController,
            hintText: TextConstants.receiverNumber,
            fillColor: AppColors.white,
            borderColor: AppColors.lightBlack20,
            showBorder: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: InputFieldValidator.phoneNumber(),
          ),
          OutlinedInputField(
            controller: widget.controller.transactionController,
            hintText: TextConstants.transactionId,
            fillColor: AppColors.white,
            borderColor: AppColors.lightBlack20,
            showBorder: true,
          ),
          OutlinedInputField(
            controller: widget.controller.amountController,
            hintText: TextConstants.amount,
            fillColor: AppColors.white,
            borderColor: AppColors.lightBlack20,
            showBorder: true,
            keyboardType: TextInputType.number,
            validator: InputFieldValidator.name(),
          ),

          Container(
            height: 41,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.lightBlack20,
                width: 0.5,
              ),
            ),
            width: double.infinity,
            child: CommonPopupMenu(
              value: widget.controller.selectedVendor ??
                  TextConstants.paymentMethod,
              dropdownItems: const [
                TextConstants.bkash,
                TextConstants.nagad,
                TextConstants.rocket,
              ],
              onChanged: (value) {
                setState(() {
                  widget.controller.selectedVendor = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () {
              final checkoutController = Get.find<CheckoutViewController>();

              if (checkoutController.isSuccessful) {
                return TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        barrierDismissible: false,
                        barrierColor: AppColors.lightBlack60,
                        context: context,
                        builder: (context) {
                          if (checkoutController
                                  .paymentInstructionModel?.value?.isNotEmpty ??
                              false) {
                            return _ManualPaymentInstructionVideo(
                              videoLink: checkoutController
                                  .paymentInstructionModel!.value!,
                            );
                          }

                          return const Offstage();
                        },
                      );
                    });
                  },
                  child: Text(
                    'Click here for payment instruction',
                    style: AppTextStyle.semibold14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else {
                return const Offstage();
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _ManualPaymentInstructionVideo extends StatelessWidget {
  const _ManualPaymentInstructionVideo({
    required this.videoLink,
  });
  final String videoLink;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CommonVideoPlayer(
                autoPlayVideo: true,
                videoLink: videoLink,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lightBlack10.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.lightBlack20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

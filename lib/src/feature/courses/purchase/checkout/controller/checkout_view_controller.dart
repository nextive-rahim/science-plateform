import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/payment_instruction_model.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/payment/repository/payment_repository.dart';

class CheckoutViewController extends GetxController {
  final CourseRepository repository = CourseRepository();
  final PaymentRepository paymentRepository = PaymentRepository();
  CoursePurchaseController coursePurchaseController =
      Get.find<CoursePurchaseController>();
  CourseDetailsViewController courseDetailsViewController =
      Get.find<CourseDetailsViewController>();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  PageState get pageState => _pageStateController.value;
  bool get isSuccessful => pageState == PageState.success;
  bool get isLoading => (coursePurchaseController.isLoading);
  bool get hasError => pageState == PageState.error;

  /// Models
  CourseModel? courseModel;

  PaymentInstructionResponseModel? _paymentInstructionResponseModel;
  PaymentInstructionModel? paymentInstructionModel;

  double totalAmount = 0.0;
  double discountAmount = 0.0;
  double couponAmount = 0.0;
  double payableAmount = 0.0;
//  bool get hasPaymentData =>
//       receiverController.text.isEmpty ||
//       senderController.text.isEmpty ||
//       transactionController.text.isEmpty ||
//       selectedVendor == null ||
//       selectedVendor!.isEmpty;
//   String? selectedPaymentMethod;
//   String? selectedPaymentProvider;
//   late PaymentResponseModel paymentResponseModel;
//   late PaymentDataModel paymentDataModel;
//   OrderDataModel? orderDataModel;
//   String? selectedVendor;

  @override
  void onInit() {
    super.onInit();
    setCourseModel();
    getManualPaymentInstruction();
  }

  void setCourseModel() {
    coursePurchaseController.orderDataModel = null;
    courseModel = coursePurchaseController.courseModel;
    if (courseModel != null) {
      totalAmount = (courseModel?.price?.amount ?? 0).toDouble();
      discountAmount = (courseModel?.price?.discount ?? 0).toDouble();
      couponAmount = courseDetailsViewController.couponDiscount;
      payableAmount = courseDetailsViewController.coursePrice.value;
    }
  }

  Future<void> getManualPaymentInstruction() async {
    _pageStateController(PageState.loading);

    try {
      final res = await paymentRepository.fetchPaymentInstruction();
      _paymentInstructionResponseModel =
          PaymentInstructionResponseModel.fromJson(res);
      paymentInstructionModel = _paymentInstructionResponseModel?.data;
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
    }
  }

  /// Controllers
  TextEditingController receiverController = TextEditingController();
  TextEditingController senderController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
}

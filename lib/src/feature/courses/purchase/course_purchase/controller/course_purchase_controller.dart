import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/classroom/root/controller/classroom_view_controller.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/bkash_model.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/cart_model.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/order_model.dart';
import 'package:science_platform/src/feature/courses/purchase/checkout/model/payment_model.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/repository/course_purchase_repository.dart';
import 'package:science_platform/src/feature/courses/root/controller/course_details_view_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/feature/payment/repository/payment_repository.dart';
import 'package:science_platform/src/routes/app_pages.dart';

class CoursePurchaseController extends GetxController {
  final CoursePurchaseRepository _repository = CoursePurchaseRepository();
  final PaymentRepository paymentRepository = PaymentRepository();
  final CourseDetailsViewController _courseDetailsViewController =
      Get.find<CourseDetailsViewController>();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  bool get isLoading => pageState == PageState.loading;
  late CourseModel courseModel;

  final Rx<PageState> _digitalPaymentStateController = Rx(PageState.initial);
  get digitalPaymentState => _digitalPaymentStateController.value;
  bool get isDigitalPaymentLoading => digitalPaymentState == PageState.loading;

  /// Place Order
  OrderResponseModel? orderResponseModel;
  OrderDataModel? orderDataModel;
  CartModel? cartModel;
  Instalment? instalment;
  String? appliedCoupon;
  String? bkashWebviewUrl;

  int impossibleItemLength = 1000;
  final int _fullPriceItemValue = -1;
  final int _notFullPriceItemValue = -2;

  int get getFullPriceItemValue => _fullPriceItemValue;

  Rx<int> groupValue = (-1).obs;

  RxList<Instalment> selectedInstalments = <Instalment>[].obs;
  bool get hasPaymentData =>
      receiverController.text.isEmpty ||
      senderController.text.isEmpty ||
      transactionController.text.isEmpty ||
      selectedVendor == null ||
      selectedVendor!.isEmpty;
  String? selectedPaymentMethod;
  String? selectedPaymentProvider;
  late PaymentResponseModel paymentResponseModel;
  late PaymentDataModel paymentDataModel;
  String? selectedVendor;

  @override
  void onInit() {
    super.onInit();
    selectedInstalments.clear();
  }

  Future<void> bkashPaymentOrder(orderId) async {
    _digitalPaymentStateController(PageState.loading);
    Map<String, dynamic> requestBody = {'order_id': orderId};

    try {
      final res = await paymentRepository.bkashPaymentOrder(requestBody);
      BkashPaymentResponseModel bkashModel = BkashPaymentResponseModel.fromJson(
        res,
      );
      bkashWebviewUrl = bkashModel.url!;
      _digitalPaymentStateController(PageState.success);
      Get.offNamed(Routes.bkashWebview, arguments: bkashWebviewUrl);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _digitalPaymentStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Selecting or removing Instalment
  void addOrRemoveSelectedItem(Instalment? instalment) {
    if (selectedInstalments.contains(instalment)) {
      selectedInstalments.remove(instalment);

      bool hasItemsThatDependOnThisInstalment = courseModel.instalments
              ?.any((element) => element.instalmentId == instalment?.id) ??
          false;

      /// checking if there's any dependent instalment selected, remove if there's any
      if (hasItemsThatDependOnThisInstalment) {
        for (var addedInstalment in selectedInstalments) {
          _removeIfPreviousInstalmentIsNotSelected(addedInstalment);
        }
      }
    } else {
      selectedInstalments.add(instalment!);
    }
    _checkIfAnyInstalmentIsSelected();
  }

  /// check if the total price or any instalment is selected
  void _checkIfAnyInstalmentIsSelected() {
    if (selectedInstalments.isNotEmpty) {
      groupValue.value = _notFullPriceItemValue;
    } else {
      groupValue.value = _fullPriceItemValue;
    }
  }

  /// check if the previous instalment is selected
  bool checkIfPreviousInstalmentIsSelected(Instalment? instalment) {
    bool isAdded = true;
    bool itemFound = selectedInstalments
        .any((element) => element.id == instalment?.instalmentId);
    bool previousItemIsPurchased = courseModel.instalments?.any((element) {
          return (element.id == instalment?.instalmentId &&
              element.purchased == true);
        }) ??
        false;
    if (instalment?.instalmentId == null ||
        previousItemIsPurchased ||
        itemFound) {
      isAdded = true;
    } else {
      isAdded = false;
    }
    return isAdded;
  }

  /// remove the items if the previous instalment is not selected
  void _removeIfPreviousInstalmentIsNotSelected(Instalment? instalment) {
    bool previousInstalmentFound = selectedInstalments
        .any((element) => element.id == instalment?.instalmentId);

    if (instalment?.instalmentId != null && !previousInstalmentFound) {
      addOrRemoveSelectedItem(instalment);
    }
  }

  void _assignCartModel() {
    appliedCoupon = Get.find<CourseDetailsViewController>().appliedCoupon.value;
    if (groupValue.value == -1) {
      cartModel = CartModel(
        priceId: courseModel.price?.id,
        coupon: appliedCoupon,
      );
    } else {
      // cartModel = CartModel(
      //   items: selectedInstalments
      //       .map(
      //         (e) => Item(
      //           itemId: e.id,
      //           quantity: 1,
      //           type: "instalment",
      //         ),
      //       )
      //       .toList(),
      // );
    }
  }

  Future<void> placeOrder() async {
    if (courseModel.isFreeCourse ||
        _courseDetailsViewController.coursePrice.value == 0) {
      enrollInFreeCourse();
      return;
    }

    _assignCartModel();

    Log.debug('appliedCoupon while placing order: $appliedCoupon');

    _pageStateController(PageState.loading);

    try {
      final res = await _repository.placeOrder(cartModel!.toJson());
      orderResponseModel = OrderResponseModel.fromJson(res);
      orderDataModel = orderResponseModel?.data;
      _pageStateController(PageState.success);
      _courseDetailsViewController.cancelCoupon();
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<void> placePaymentOrder(
      OrderDataModel? orderDataModel, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);

    Map<String, dynamic> requestBody = {
      'order_id': orderDataModel?.id,
      'paid_account': receiverController.text,
      'payment_account': senderController.text,
      'transaction_id': transactionController.text,
      'method': 'manual',
      'amount': amountController.text,
      'vendor': selectedVendor,
    };

    try {
      final res = await paymentRepository.paymentOrder(requestBody);
      paymentResponseModel = PaymentResponseModel.fromJson(res);
      paymentDataModel = paymentResponseModel.data!;

      Get.offAllNamed(
        Routes.congratulation,
        arguments: paymentDataModel,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Order payment failed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }

  Future<void> enrollInFreeCourse() async {
    _pageStateController(PageState.loading);

    _assignCartModel();

    try {
      final res = await _repository.placeOrder(cartModel!.toJson());
      orderResponseModel = OrderResponseModel.fromJson(res);
      orderDataModel = orderResponseModel?.data;

      await _repository.enrollInFreeCourse(
        orderId: orderDataModel!.id!,
      );

      _pageStateController(PageState.success);

      Get.find<ClassroomViewController>().fetchMyCourses();
      Get.find<CourseSectionsViewController>()
          .getCourseSectionsAndContents(courseModel.slug!);
      Get.offNamedUntil(
        Routes.courseSections,
        (route) => route.settings.name == Routes.dashboard,
      );
      Get.snackbar(
        'Success',
        'Enrolled in ${orderDataModel?.itemTitle} successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Controllers
  TextEditingController receiverController = TextEditingController();
  TextEditingController senderController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
}

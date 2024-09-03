import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/feature/courses/purchase/course_purchase/controller/course_purchase_controller.dart';
import 'package:science_platform/src/feature/courses/root/model/coupon_validate_response_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_details_response_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/courses/root/repository/course_repository.dart';
import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class CourseDetailsViewController extends GetxController {
  final CourseRepository repository = CourseRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;
  bool get isLoading => pageState == PageState.loading;

  final Rx<PageState> _couponStateController = Rx(PageState.initial);

  get couponState => _couponStateController.value;

  RxBool contentsLoading = true.obs;
  RxBool isPromoCodeFieldVisible = false.obs;

  bool get sectionHasData => sectionContents.isNotEmpty;
  CoursePurchaseController? purchaseController;
  late CourseDetailsResponseModel courseDetailsModel;
  CourseModel? courseDetails;
  SectionModel? sectionModel;
  List<ContentModel> sectionContents = [];
  CouponValidateResponseModel? couponValidateResponse;
  double couponDiscount = 0;
  RxString appliedCoupon = ''.obs;
  RxDouble coursePrice = 0.0.obs;

  void setCoursePrice() {
    double price = 0;
    if (courseDetails.isNotNull) {
      price = double.tryParse(courseDetails!.netPrice) ?? 0;
    }

    double afterDiscount = (price - couponDiscount);
    coursePrice.value = afterDiscount < 0 ? 0 : afterDiscount;
  }

  Future<void> fetchCourseDetails(String slug) async {
    _pageStateController(PageState.loading);
    isPromoCodeFieldVisible.value = false;
    try {
      final res = await repository.fetchCourseDetails(slug);
      courseDetailsModel = CourseDetailsResponseModel.fromJson(res);
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
    courseDetails = courseDetailsModel.data;
    purchaseController = Get.find<CoursePurchaseController>();
    purchaseController?.courseModel = courseDetails!;
    promoCodeController.clear();
    appliedCoupon.value = '';
    Log.debug('appliedCoupon while fetching details: $appliedCoupon');
    couponDiscount = 0;
    setCoursePrice();
    _pageStateController(PageState.success);
  }

  Future<void> getSectionContents(String slug) async {
    contentsLoading.value = true;
    try {
      final res = await repository.fetchSectionContents(slug);
      log('section contents: $res');
      sectionContents =
          List.from(res['data']).map((e) => ContentModel.fromJson(e)).toList();
      contentsLoading.value = false;
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      contentsLoading.value = false;
      return;
    }
  }

  Future<void> applyCoupon() async {
    if (promoCodeController.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Please enter the coupon code!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Map<String, dynamic> requestBody = {
      "code": promoCodeController.text,
      "price_id": courseDetails?.price?.id,
    };

    _couponStateController(PageState.loading);

    try {
      final res = await repository.applyCoupon(requestBody);
      couponValidateResponse = CouponValidateResponseModel.fromJson(res);

      if (couponValidateResponse.isNotNull ||
          couponValidateResponse?.discount != null) {
        couponDiscount = (couponValidateResponse?.discount ?? 0).toDouble();
      }

      appliedCoupon.value = promoCodeController.text;
      Log.debug('appliedCoupon after applying: $appliedCoupon');
      promoCodeController.clear();
      setCoursePrice();
      _couponStateController(PageState.success);
      Get.snackbar(
        'Success!',
        'Coupon applied successfully!',
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _couponStateController(PageState.error);
    }
  }

  void togglePromoCodeField() {
    isPromoCodeFieldVisible.value = !isPromoCodeFieldVisible.value;
  }

  void cancelCoupon() {
    couponDiscount = 0;
    appliedCoupon.value = '';
    setCoursePrice();
  }

  /// controllers
  TextEditingController promoCodeController = TextEditingController();

  @override
  void onClose() {
    promoCodeController.clear();
    super.onClose();
  }
}

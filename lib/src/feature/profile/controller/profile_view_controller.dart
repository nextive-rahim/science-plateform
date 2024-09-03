import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:science_platform/src/core/logger.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/service/cache/cache_keys.dart';
import 'package:science_platform/src/core/service/cache/cache_service.dart';
import 'package:science_platform/src/feature/courses/sections/controller/course_sections_view_controller.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/feature/profile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  final UserRepository _repository = UserRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;

  late UserModel userModel;

  /// File
  RxBool isProfilePictureSelected = false.obs;
  File? _profilePictureFile;

  File? get profilePicture =>
      _profilePictureFile;
  RxBool? isShowImageDailogProvider = false.obs;
  // void clearProfilePicture() {
  //   _profilePictureFile = null;
  //   isProfilePictureSelected.value = false;
  // }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      _profilePictureFile = imageTemporary;
      isProfilePictureSelected.value = true;
      isShowImageDailogProvider!.value = true;
      //this.image = imageTemporary;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  // Future<void> chooseProfilePicture() async {
  //   _profilePictureFile = await FileService().pickAFile();
  //   _fileDebug(_profilePictureFile);
  // }

  // void _fileDebug(FileModel? file) {
  //   isProfilePictureSelected.value = false;
  //   if (file != null) {
  //     final fileSize = file.file.lengthSync() / 1024;
  //     Log.info('KB $fileSize');
  //     if (fileSize > 2024) {
  //       Get.snackbar(
  //         'Caution',
  //         'File size has to be less than 2MB',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //       return;
  //     }
  //     isProfilePictureSelected.value = true;
  //     Log.info(file.name);
  //     Log.info(file.file.path);
  //   }
  // }

  @override
  void onInit() async {
    //TODO: FIX THIS
    CacheService.boxAuth.read(CacheKeys.token) != null
        ? await fetchCacheUserData()
        : null;
    Get.put(CourseSectionsViewController());
    super.onInit();
  }

  Future<void> fetchCacheUserData() async {
    _pageStateController(PageState.loading);

    try {
      userModel = await _repository.fetchUser();

      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Fetching user data failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //TODO: Handle image update
  Future<void> updateProfileData(GlobalKey<FormState> key) async {
    if (!key.currentState!.validate()) {
      return;
    }
    _pageStateController(PageState.loading);

    Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      "_method": "PUT",
      "educational_session": sessionController.text

      // if (_profilePictureFile != null)
      //   "photo": await dio.MultipartFile.fromFile(
      //     _profilePictureFile!.path,
      //   ),
    };

    try {
      final res = await _repository.updateUserData(
        requestBody,
      );
      userModel = UserModel.fromJson(res["data"]);
      CacheService.boxAuth.write(
        CacheKeys.user,
        userModel.toJson(),
      );
      _pageStateController(PageState.success);
      Get.snackbar(
        'Success',
        'Personal information updated successfully',
        snackPosition: SnackPosition.TOP,
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
    }
  }

  void populateTextFields() {
    nameController.text = userModel.name;
    emailController.text = userModel.email;
    phoneController.text = userModel.phone;
    instituteController.text = userModel.institution;
    sessionController.text = userModel.educationalSession;
  }

  /// Text Editing Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController sessionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:science_platform/src/core/page_state/state.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/core/validators/input_form_validators.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:science_platform/src/feature/profile/view/profile_info_page.dart';
import 'package:science_platform/src/utils/text_constants.dart';
import 'package:science_platform/src/widgets/common_dialog.dart';
import 'package:science_platform/src/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:science_platform/src/widgets/outlined_input_field.dart';
import 'package:science_platform/src/widgets/primary_button.dart';

class ProfileUpdatePage extends GetView<ProfileViewController> {
  ProfileUpdatePage({super.key}) {
    controller.populateTextFields();
  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4FA),
      appBar: AppBar(
        title: const Text('Edit Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionContainer(
            title: 'Basic Information',
            titleColor: Colors.black,
            horizontalPadding: 15,
            verticalPadding: 15,
            radius: 15,
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _UploadProfilePicture(
                      controller: controller,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const GradientTitle(title: TextConstants.name),
                        const SizedBox(height: 5),
                        OutlinedInputField(
                          showBorder: false,
                          fillColor: const Color(0xFFF1F2FF),
                          controller: controller.nameController,
                          hintText: TextConstants.fullName,
                          validator: InputFieldValidator.name(),
                        ),
                        const GradientTitle(title: TextConstants.profession),
                        const SizedBox(height: 5),
                        OutlinedInputField(
                          readOnly: true,
                          showBorder: false,
                          fillColor: const Color(0xFFF1F2FF),
                          controller: TextEditingController(),
                          hintText: 'Student',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SectionContainer(
            title: 'Educational Information',
            titleColor: Colors.black,
            horizontalPadding: 15,
            verticalPadding: 15,
            radius: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GradientTitle(title: TextConstants.instituteName),
                const SizedBox(height: 5),
                OutlinedInputField(
                  showBorder: false,
                  fillColor: const Color(0xFFF1F2FF),
                  controller: controller.instituteController,
                  hintText: TextConstants.instituteName,
                  validator: InputFieldValidator.name(),
                ),
                const GradientTitle(title: TextConstants.session),
                const SizedBox(height: 5),
                OutlinedInputField(
                  showBorder: false,
                  fillColor: const Color(0xFFF1F2FF),
                  controller: controller.sessionController,
                  hintText: TextConstants.session,
                  validator: InputFieldValidator.name(),
                ),
              ],
            ),
          ),
          SectionContainer(
            title: 'Personal Information',
            titleColor: Colors.black,
            horizontalPadding: 15,
            verticalPadding: 15,
            radius: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GradientTitle(title: TextConstants.phoneNumber),
                const SizedBox(height: 5),
                OutlinedInputField(
                  readOnly: true,
                  showBorder: false,
                  fillColor: const Color(0xFFF1F2FF),
                  controller: controller.phoneController,
                  hintText: TextConstants.session,
                  validator: InputFieldValidator.name(),
                ),
                const GradientTitle(title: TextConstants.email),
                const SizedBox(height: 5),
                OutlinedInputField(
                  showBorder: false,
                  fillColor: const Color(0xFFF1F2FF),
                  controller: controller.emailController,
                  hintText: TextConstants.email,
                  validator: InputFieldValidator.name(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          PrimaryButton(
            onTap: () {
              controller.updateProfileData(formKey);
            },
            isLoading: controller.pageState == PageState.loading,
            widget: Text(
              'Save',
              style: AppTextStyle.bold16.copyWith(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }

  Text _buildLabel(String labelText) {
    return Text(
      labelText,
      style: const TextStyle(
        color: AppColors.primary,
        fontFamily: 'NotoSerifBengali',
      ),
    );
  }
}

class _UploadProfilePicture extends StatelessWidget {
  const _UploadProfilePicture({
    required this.controller,
  });
  final ProfileViewController controller;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 147,
        width: 147,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            _showModalSheet(context, controller);
          },
          child: Column(
            children: [
              Obx(
                () => Stack(
                  children: [
                    controller.isProfilePictureSelected.value == true
                        ? SizedBox(
                            height: 147,
                            width: 147,
                            child: Image.file(
                              controller.profilePicture!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox(
                            height: 147,
                            width: 147,
                            child: Image.network(
                              controller.userModel.image?.link ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 68,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Upload a new Profile Picture',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDailogBox(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonDialog(
        context: context,
        isDismissible: false,
        bodyContent: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.file(controller.profilePicture!),
              const SizedBox(height: 20),
            ],
          ),
        ),
        onYesPressed: () {
          controller.isShowImageDailogProvider!.value = false;

          Get.back();
        },
        onNoPressed: () {
          controller.isShowImageDailogProvider!.value = false;
          controller.profilePicture;
          Get.back();
        },
      );
    });
  }
}

void _showModalSheet(
  BuildContext context,
  ProfileViewController controller,
) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (builder) {
      return Container(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 30,
        ),
        height: 108.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.gallery);
                Get.back();
              },
              child: const Text(
                'Photo Gallery',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.primary,
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.getImage(ImageSource.camera);
                Get.back();
              },
              child: const Text(
                'Camera',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    },
  );
}

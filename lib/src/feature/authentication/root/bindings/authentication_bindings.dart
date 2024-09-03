import 'package:science_platform/src/feature/authentication/forgot_password/controller/forgot_password_view_controller.dart';
import 'package:science_platform/src/feature/authentication/login/controller/login_view_controller.dart';
import 'package:science_platform/src/feature/authentication/otp/controller/otp_view_controller.dart';
import 'package:science_platform/src/feature/authentication/set_new_password/controller/set_new_password_view_controller.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/otp_verification_view_controller.dart.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/phone_number_verification_view_controller.dart';
import 'package:science_platform/src/feature/authentication/signup/controller/sign_up_view_controller.dart';
import 'package:science_platform/src/feature/profile/controller/profile_view_controller.dart';
import 'package:get/get.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordViewController(), fenix: true);
    Get.lazyPut(() => SignUpViewController(), fenix: true);
    Get.lazyPut(() => OtpViewController(), fenix: true);
    Get.lazyPut(() => SetNewPasswordViewController(), fenix: true);
    Get.lazyPut(() => OtpVerificationViewController(), fenix: true);
    Get.lazyPut(() => ProfileViewController(), fenix: true);
    Get.lazyPut(() => PhoneNumberVerificationViewController(), fenix: true);
  }
}

import 'package:science_platform/src/core/logger.dart';
import 'package:get/get.dart';

void errorHandler(
  Object e,
  StackTrace stackTrace, {
  String feedback = "Something went wrong",
  bool disableFeedback = false,
}) {
  Log.error(e.toString());
  Log.error(stackTrace.toString());
  Get.snackbar(
    'Failed',
    feedback,
    snackPosition: SnackPosition.BOTTOM,
  );
}

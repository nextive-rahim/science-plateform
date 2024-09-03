import 'package:get/get.dart';

class InputFieldValidator {
  static String? Function(String?) name({
    String? Function()? callBack,
    String feedback = "Required",
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return feedback;
      }

      /// For fields that needs to show validation error from server
      if (callBack != null) {
        return callBack();
      }

      return null;
    };
  }

  static String? Function(String?) phoneNumber({
    String? Function()? callBack,
    String feedback = "Please enter phone number",
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return feedback;
      } else if (value[0] != '0' || value[1] != '1') {
        return 'Number must starts with "01".';
      } else if (value.isNumericOnly) {
        if (value.length != 11) {
          return 'Please enter your ${11} digit phone number';
        }
      } else if (value.length != 13) {
        return 'Please enter your ${11} digit phone number';
      } else if (value == "00000000000000000") {
        return 'Please enter valid phone number';
      }

      /// For fields that needs to show validation error from server
      if (callBack != null) {
        return callBack();
      }

      return null;
    };
  }

  static String? Function(String?) password({
    String? Function()? callBack,
    String feedback = "Required",
    bool optional = false,
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return optional ? null : feedback;
      } else if (value.length < 6) {
        return "Must be more than 6 character";
      }

      /// For fields that needs to show validation error from server
      if (callBack != null) {
        return callBack();
      }

      return null;
    };
  }

  static String? Function(String?) confirmPassword({
    String? Function()? callBack,
    String feedback = "Required",
    bool optional = false,
    String? password,
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return optional ? null : feedback;
      } else if (value.length < 6) {
        return "Must be more than 6 character";
      } else if (value != password) {
        return "Password must match";
      }

      /// For fields that needs to show validation error from server
      if (callBack != null) {
        return callBack();
      }

      return null;
    };
  }

  static String? Function(String?) email({
    String? Function()? callBack,
    String feedback = "Required",
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return feedback;
      }
      return null;
    };
  }

  static String? Function(String?) otp({
    String? Function()? callBack,
    String feedback = "Required",
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return feedback;
      } else if (value.length < 6 || value.length > 6) {
        return "Must be 6 character";
      }
      return null;
    };
  }
}

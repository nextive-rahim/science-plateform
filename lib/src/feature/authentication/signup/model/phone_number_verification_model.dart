// To parse this JSON data, do
//
//     final phoneNumberVerificationResponseModel = phoneNumberVerificationResponseModelFromJson(jsonString);

import 'dart:convert';

PhoneNumberVerificationResponseModel
    phoneNumberVerificationResponseModelFromJson(String str) =>
        PhoneNumberVerificationResponseModel.fromJson(json.decode(str));

String phoneNumberVerificationResponseModelToJson(
        PhoneNumberVerificationResponseModel data) =>
    json.encode(data.toJson());

class PhoneNumberVerificationResponseModel {
  String status;
  DateTime? phoneVerifiedAt;
  String message;

  PhoneNumberVerificationResponseModel({
    required this.status,
    this.phoneVerifiedAt,
    required this.message,
  });

  factory PhoneNumberVerificationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      PhoneNumberVerificationResponseModel(
        status: json["status"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
        "message": message,
      };
}

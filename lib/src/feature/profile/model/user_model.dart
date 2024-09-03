import 'package:science_platform/src/models/image_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String phone;
  dynamic institution;
  dynamic educationalSession;
  dynamic deviceId;
  dynamic fcmToken;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  String role;
  ImageModel? image;
  dynamic pivot;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.institution,
    this.educationalSession,
    this.deviceId,
    this.fcmToken,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.role,
    this.image,
    this.pivot,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"] ?? '',
        phone: json["phone"],
        institution: json["institution"],
        educationalSession: json["educational_session"],
        deviceId: json["device_id"],
        fcmToken: json["fcm_token"],
        emailVerifiedAt: json["email_verified_at"],
        phoneVerifiedAt: json["phone_verified_at"],
        role: json["role"] ?? '',
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
        pivot: json["pivot"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "institution": institution,
        "educational_session": educationalSession,
        "device_id": deviceId,
        "fcm_token": fcmToken,
        "email_verified_at": emailVerifiedAt,
        "phone_verified_at": phoneVerifiedAt,
        "role": role,
        "image": image,
        "pivot": pivot,
      };
}

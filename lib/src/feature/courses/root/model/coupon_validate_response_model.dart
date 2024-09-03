import 'dart:convert';

class CouponValidateResponseModel {
  String? code;
  int? discount;

  CouponValidateResponseModel({
    this.code,
    this.discount,
  });

  CouponValidateResponseModel copyWith({
    String? code,
    int? discount,
  }) =>
      CouponValidateResponseModel(
        code: code ?? this.code,
        discount: discount ?? this.discount,
      );

  factory CouponValidateResponseModel.fromRawJson(String str) =>
      CouponValidateResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponValidateResponseModel.fromJson(Map<String, dynamic> json) =>
      CouponValidateResponseModel(
        code: json["code"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "discount": discount,
      };
}

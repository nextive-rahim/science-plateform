// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

class CouponModel {
  int? priceId;
  String? code;

  CouponModel({
    this.priceId,
    this.code,
  });

  CouponModel copyWith({
    int? priceId,
    String? code,
  }) =>
      CouponModel(
        priceId: priceId ?? this.priceId,
        code: code ?? this.code,
      );

  factory CouponModel.fromRawJson(String str) =>
      CouponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        priceId: json["price_id"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "price_id": priceId,
        "code": code,
      };
}

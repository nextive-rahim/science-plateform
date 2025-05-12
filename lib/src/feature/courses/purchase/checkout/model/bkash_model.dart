import 'dart:convert';

BkashPaymentResponseModel bkashPaymentResponseModelFromJson(String str) =>
    BkashPaymentResponseModel.fromJson(json.decode(str));

String bkashPaymentResponseModelToJson(BkashPaymentResponseModel data) =>
    json.encode(data.toJson());

class BkashPaymentResponseModel {
  String? url;

  BkashPaymentResponseModel({
    this.url,
  });

  factory BkashPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      BkashPaymentResponseModel(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

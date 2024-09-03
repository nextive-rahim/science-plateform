import 'dart:convert';

class PriceModel {
  int? id;
  String? title;
  int? amount;
  dynamic discount;
  DateTime? discountTill;
  String? validityType;
  DateTime? validityTime;
  int? validityDuration;

  PriceModel({
    this.id,
    this.title,
    this.amount,
    this.discount,
    this.discountTill,
    this.validityType,
    this.validityTime,
    this.validityDuration,
  });

  PriceModel copyWith({
    int? id,
    String? title,
    int? amount,
    dynamic discount,
    DateTime? discountTill,
    String? validityType,
    DateTime? validityTime,
    int? validityDuration,
  }) =>
      PriceModel(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        discount: discount ?? this.discount,
        discountTill: discountTill ?? this.discountTill,
        validityType: validityType ?? this.validityType,
        validityTime: validityTime ?? this.validityTime,
        validityDuration: validityDuration ?? this.validityDuration,
      );

  factory PriceModel.fromRawJson(String str) =>
      PriceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        validityType: json["validity_type"],
        validityTime: json["validity_time"] == null
            ? null
            : DateTime.parse(json["validity_time"]),
        validityDuration: json["validity_duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "discount": discount,
        "discount_till": discountTill?.toIso8601String(),
        "validity_type": validityType,
        "validity_time": validityTime?.toIso8601String(),
        "validity_duration": validityDuration,
      };
}

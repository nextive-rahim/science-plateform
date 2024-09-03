// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

class OrderResponseModel {
  OrderDataModel? data;

  OrderResponseModel({
    this.data,
  });

  OrderResponseModel copyWith({
    OrderDataModel? data,
  }) =>
      OrderResponseModel(
        data: data ?? this.data,
      );

  factory OrderResponseModel.fromRawJson(String str) =>
      OrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        data:
            json["data"] == null ? null : OrderDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class OrderDataModel {
  int? id;
  int? userId;
  int? priceId;
  int? amount;
  int? discount;
  int? total;
  String? coupon;
  String? status;
  String? priceTitle;
  String? itemTitle;
  dynamic payment;
  DateTime? createdAt;

  OrderDataModel({
    this.id,
    this.userId,
    this.priceId,
    this.amount,
    this.discount,
    this.total,
    this.coupon,
    this.status,
    this.priceTitle,
    this.itemTitle,
    this.payment,
    this.createdAt,
  });

  OrderDataModel copyWith({
    int? id,
    int? userId,
    int? priceId,
    int? amount,
    int? discount,
    int? total,
    String? coupon,
    String? status,
    String? priceTitle,
    String? itemTitle,
    dynamic payment,
    DateTime? createdAt,
  }) =>
      OrderDataModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        priceId: priceId ?? this.priceId,
        amount: amount ?? this.amount,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        coupon: coupon ?? this.coupon,
        status: status ?? this.status,
        priceTitle: priceTitle ?? this.priceTitle,
        itemTitle: itemTitle ?? this.itemTitle,
        payment: payment ?? this.payment,
        createdAt: createdAt ?? this.createdAt,
      );

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
        id: json["id"],
        userId: json["user_id"],
        priceId: json["price_id"],
        amount: json["amount"],
        discount: json["discount"],
        total: json["total"],
        coupon: json["coupon"],
        status: json["status"],
        priceTitle: json["price_title"],
        itemTitle: json["item_title"],
        payment: json["payment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "price_id": priceId,
        "amount": amount,
        "discount": discount,
        "total": total,
        "coupon": coupon,
        "status": status,
        "price_title": priceTitle,
        "item_title": itemTitle,
        "payment": payment,
        "created_at": createdAt?.toIso8601String(),
      };
}

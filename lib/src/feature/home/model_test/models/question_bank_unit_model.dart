import 'dart:convert';

class QuestionBankUnitModel {
  QuestionBankUnitModel({
    this.id,
    this.title,
    this.slug,
    this.photo,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.order,
    this.active,
    this.isSubscribed,
  });

  int? id;
  String? title;
  String? slug;
  dynamic photo;
  dynamic price;
  dynamic discount;
  DateTime? discountTill;
  String? discountedPrice;
  dynamic order;
  bool? active;
  bool? isSubscribed;

  QuestionBankUnitModel copyWith({
    int? id,
    String? title,
    String? slug,
    dynamic photo,
    dynamic price,
    dynamic discount,
    DateTime? discountTill,
    String? discountedPrice,
    dynamic order,
    bool? active,
    bool? isSubscribed,
  }) =>
      QuestionBankUnitModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        photo: photo ?? this.photo,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountTill: discountTill ?? this.discountTill,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        order: order ?? this.order,
        active: active ?? this.active,
        isSubscribed: isSubscribed ?? this.isSubscribed,
      );

  factory QuestionBankUnitModel.fromRawJson(String str) =>
      QuestionBankUnitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionBankUnitModel.fromJson(Map<String, dynamic> json) =>
      QuestionBankUnitModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        photo: json["photo"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice: json["discounted_price"],
        order: json["order"],
        active: json["active"],
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "photo": photo,
        "price": price,
        "discount": discount,
        "discount_till": discountTill?.toIso8601String(),
        "discounted_price": discountedPrice,
        "order": order,
        "active": active,
        "is_subscribed": isSubscribed,
      };
}

import 'dart:convert';

import 'package:science_platform/src/feature/home/model_test/models/question_bank_varsity_model.dart';

class QuestionBankResponseModel {
  QuestionBankResponseModel({
    this.data,
  });

  List<QuestionBankItemModel>? data;

  QuestionBankResponseModel copyWith({
    List<QuestionBankItemModel>? data,
  }) =>
      QuestionBankResponseModel(
        data: data ?? this.data,
      );

  factory QuestionBankResponseModel.fromRawJson(String str) =>
      QuestionBankResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionBankResponseModel.fromJson(Map<String, dynamic> json) =>
      QuestionBankResponseModel(
        data: json["data"] == null
            ? null
            : List<QuestionBankItemModel>.from(
                json["data"].map((x) => QuestionBankItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class QuestionBankItemModel {
  QuestionBankItemModel({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.order,
    this.active,
    this.children,
    this.childrenCount,
  });

  int? id;
  int? parentId;
  String? name;
  String? slug;
  String? photo;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  dynamic order;
  bool? active;
  List<QuestionBankVarsityModel>? children;
  int? childrenCount;

  QuestionBankItemModel copyWith({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? photo,
    dynamic price,
    dynamic discount,
    dynamic discountTill,
    dynamic discountedPrice,
    dynamic order,
    bool? active,
    List<QuestionBankVarsityModel>? children,
    int? childrenCount,
  }) =>
      QuestionBankItemModel(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        photo: photo ?? this.photo,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountTill: discountTill ?? this.discountTill,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        order: order ?? this.order,
        active: active ?? this.active,
        children: children ?? this.children,
        childrenCount: childrenCount ?? this.childrenCount,
      );

  factory QuestionBankItemModel.fromRawJson(String str) =>
      QuestionBankItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionBankItemModel.fromJson(Map<String, dynamic> json) =>
      QuestionBankItemModel(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        order: json["order"],
        active: json["active"],
        children: json["children"] == null
            ? null
            : List<QuestionBankVarsityModel>.from(json["children"]
                .map((x) => QuestionBankVarsityModel.fromJson(x))),
        childrenCount: json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "photo": photo,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "order": order,
        "active": active,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "children_count": childrenCount,
      };
}

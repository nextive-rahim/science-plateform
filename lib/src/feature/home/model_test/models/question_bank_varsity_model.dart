import 'dart:convert';

import 'package:science_platform/src/feature/home/model_test/models/question_bank_unit_model.dart';
import 'package:science_platform/src/utils/app_constants.dart';

class QuestionBankVarsityModel {
  QuestionBankVarsityModel({
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
    this.modelTests,
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
  List<QuestionBankUnitModel>? modelTests;

  QuestionBankVarsityModel copyWith({
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
    List<QuestionBankUnitModel>? modelTests,
  }) =>
      QuestionBankVarsityModel(
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
        modelTests: modelTests ?? this.modelTests,
      );

  factory QuestionBankVarsityModel.fromRawJson(String str) =>
      QuestionBankVarsityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionBankVarsityModel.fromJson(Map<String, dynamic> json) =>
      QuestionBankVarsityModel(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"] ?? noImageFoundURL,
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        order: json["order"],
        active: json["active"],
        modelTests: json["modelTests"] == null
            ? null
            : List<QuestionBankUnitModel>.from(json["modelTests"]
                .map((x) => QuestionBankUnitModel.fromJson(x))),
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
        "modelTests": modelTests == null
            ? null
            : List<dynamic>.from(modelTests!.map((x) => x.toJson())),
      };
}

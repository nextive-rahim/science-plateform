import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:science_platform/src/models/image_model.dart';

NoticeListResponseModel noticeListResponseModelFromJson(String str) =>
    NoticeListResponseModel.fromJson(json.decode(str));

String noticeListResponseModelToJson(NoticeListResponseModel data) =>
    json.encode(data.toJson());

class NoticeListResponseModel {
  List<NoticeData>? data;

  NoticeListResponseModel({
    this.data,
  });

  factory NoticeListResponseModel.fromJson(Map<String, dynamic> json) =>
      NoticeListResponseModel(
        data: List<NoticeData>.from(
            json["data"].map((x) => NoticeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NoticeData {
  int? id;
  String? title;
  dynamic slug;
  String? body;
  DateTime? createdAt;
  List<int>? categories;
  ImageModel? image;

  NoticeData({
    this.id,
    this.title,
    this.slug,
    this.body,
    this.createdAt,
    this.categories,
    this.image,
  });
  String? get date =>
      createdAt != null ? DateFormat.yMMMMd().format(createdAt!) : null;

  String? get time =>
      createdAt != null ? DateFormat.jm().format(createdAt!) : null;
  factory NoticeData.fromJson(Map<String, dynamic> json) => NoticeData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        categories: List<int>.from(json["categories"].map((x) => x)),
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "body": body,
        "created_at": createdAt!.toIso8601String(),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "image": image!.toJson(),
      };
}

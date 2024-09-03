import 'dart:convert';

import 'package:science_platform/src/feature/courses/content/model/content_model.dart';

class SectionModel {
  int? id;
  String? slug;
  String? title;
  List<ContentModel>? contents;

  SectionModel({
    this.id,
    this.slug,
    this.title,
    this.contents,
  });

  SectionModel copyWith({
    int? id,
    String? slug,
    String? title,
    List<ContentModel>? contents,
  }) =>
      SectionModel(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        contents: contents ?? this.contents,
      );

  factory SectionModel.fromRawJson(String str) =>
      SectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        contents: json["contents"] == null
            ? []
            : List<ContentModel>.from(
                json["contents"]!.map((x) => ContentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

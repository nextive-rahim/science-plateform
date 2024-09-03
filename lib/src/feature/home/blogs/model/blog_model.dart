import 'package:science_platform/src/models/image_model.dart';
import 'dart:convert';

import 'package:science_platform/src/utils/app_constants.dart';

BlogResponseModel featuredBlogResponseModelFromJson(String str) =>
    BlogResponseModel.fromJson(json.decode(str));

String featuredBlogResponseModelToJson(BlogResponseModel data) =>
    json.encode(data.toJson());

class BlogResponseModel {
  List<BlogModel>? data;

  BlogResponseModel({
    this.data,
  });

  factory BlogResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogResponseModel(
        data: json["data"] == null
            ? []
            : List<BlogModel>.from(
                json["data"].map((x) => BlogModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlogModel {
  int? id;
  String? title;
  String? slug;
  String? subtitle;
  String? authorName;
  String? authorImage;
  DateTime? createdAt;
  ImageModel? image;
  String? body;

  BlogModel({
    this.id,
    this.title,
    this.slug,
    this.subtitle,
    this.authorName,
    this.authorImage,
    this.createdAt,
    this.image,
    this.body,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      subtitle: json["subtitle"],
      authorName: json["author_name"] ?? '',
      authorImage: json["author_image"] ?? noImageFoundURL,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      body: json['body'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "subtitle": subtitle,
        "author_name": authorName,
        "author_image": authorImage,
        "created_at": createdAt!.toIso8601String(),
        "image": image?.toJson(),
        "body": body,
      };
}

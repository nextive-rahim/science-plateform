import 'dart:convert';

import 'package:science_platform/src/models/image_model.dart';

class AdvertisementModel {
  int? id;
  String? title;
  String? description;
  String? link;
  String? type;
  ImageModel? image;

  AdvertisementModel({
    this.id,
    this.title,
    this.description,
    this.link,
    this.type,
    this.image,
  });

  AdvertisementModel copyWith({
    int? id,
    String? title,
    String? description,
    String? link,
    String? type,
    ImageModel? image,
  }) =>
      AdvertisementModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        link: link ?? this.link,
        type: type ?? this.type,
        image: image ?? this.image,
      );

  factory AdvertisementModel.fromRawJson(String str) =>
      AdvertisementModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        type: json["type"],
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "link": link,
        "type": type,
        "image": image?.toJson(),
      };
}

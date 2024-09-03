import 'dart:convert';

import 'package:science_platform/src/utils/app_constants.dart';

class ImageModel {
  int? id;
  String? link;

  ImageModel({
    this.id,
    this.link,
  });

  ImageModel copyWith({
    int? id,
    String? link,
  }) =>
      ImageModel(
        id: id ?? this.id,
        link: link ?? this.link,
      );

  factory ImageModel.fromRawJson(String str) =>
      ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        link: json["link"] ?? noImageFoundURL,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
      };
}

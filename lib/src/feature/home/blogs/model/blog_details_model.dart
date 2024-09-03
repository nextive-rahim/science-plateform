import 'package:science_platform/src/feature/home/blogs/model/blog_model.dart';

class BlogDetailsResponseModel {
  BlogDetailsResponseModel({
    this.data,
  });

  BlogModel? data;

  factory BlogDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailsResponseModel(
        data: json["data"] == null ? null : BlogModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

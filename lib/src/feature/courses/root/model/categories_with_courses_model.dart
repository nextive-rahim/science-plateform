import 'package:science_platform/src/feature/courses/root/model/category_model.dart';

class CategoriesWithCoursesResponseModel {
  List<CategoryModel>? data;

  CategoriesWithCoursesResponseModel({
    this.data,
  });

  CategoriesWithCoursesResponseModel copyWith({
    List<CategoryModel>? data,
  }) =>
      CategoriesWithCoursesResponseModel(
        data: data ?? this.data,
      );

  factory CategoriesWithCoursesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CategoriesWithCoursesResponseModel(
        data: json["data"] == null
            ? []
            : List<CategoryModel>.from(
                json["data"]!.map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/models/image_model.dart';

class CategoryModel {
  int? id;
  String? title;
  String? slug;
  List<CategoryModel>? courseCategories;
  List<CourseModel>? courses;
  ImageModel? image;

  CategoryModel({
    this.id,
    this.title,
    this.slug,
    this.courseCategories,
    this.courses,
    this.image,
  });

  CategoryModel copyWith({
    int? id,
    String? title,
    String? slug,
    List<CategoryModel>? courseCategories,
    List<CourseModel>? courses,
    ImageModel? image,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        courseCategories: courseCategories ?? this.courseCategories,
        courses: courses ?? this.courses,
        image: image ?? this.image,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        courseCategories: json["course_categories"] == null
            ? []
            : List<CategoryModel>.from(json["course_categories"]!
                .map((x) => CategoryModel.fromJson(x))),
        courses: json["courses"] == null
            ? []
            : List<CourseModel>.from(
                json["courses"]!.map((x) => CourseModel.fromJson(x))),
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "course_categories": courseCategories == null
            ? []
            : List<dynamic>.from(courseCategories!.map((x) => x.toJson())),
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "image": image?.toJson(),
      };
}

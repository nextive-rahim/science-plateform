import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/root/models/advertisement_model.dart';

class HomeResponseModel {
  List<AdvertisementModel>? advertisement;
  List<CategoryModel>? courseCategories;
  List<CourseModel>? courses;
  List<CourseModel>? modelTests;

  HomeResponseModel({
    this.advertisement,
    this.courseCategories,
    this.courses,
    this.modelTests,
  });

  HomeResponseModel copyWith({
    List<AdvertisementModel>? advertisement,
    List<CategoryModel>? courseCategories,
    List<CourseModel>? courses,
    List<CourseModel>? modelTests,
  }) =>
      HomeResponseModel(
        advertisement: advertisement ?? this.advertisement,
        courseCategories: courseCategories ?? this.courseCategories,
        courses: courses ?? this.courses,
        modelTests: modelTests ?? this.modelTests,
      );

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
        advertisement: json["advertisement"] == null
            ? []
            : List<AdvertisementModel>.from(json["advertisement"]
                .map((x) => AdvertisementModel.fromJson(x))),
        courseCategories: json["courseCategories"] == null
            ? []
            : List<CategoryModel>.from(
                json["courseCategories"].map((x) => CategoryModel.fromJson(x))),
        courses: json["courses"] == null
            ? []
            : List<CourseModel>.from(
                json["courses"].map((x) => CourseModel.fromJson(x))),
        modelTests: json["modelTests"] == null
            ? []
            : List<CourseModel>.from(
                json["modelTests"].map((x) => CourseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "advertisements": advertisement == null
            ? []
            : List<dynamic>.from(advertisement!.map((x) => x.toJson())),
        "courseCategories": courseCategories == null
            ? []
            : List<dynamic>.from(courseCategories!.map((x) => x.toJson())),
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "modelTests": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

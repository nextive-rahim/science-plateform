import 'course_model.dart';

class CourseDetailsResponseModel {
  CourseDetailsResponseModel({
    required this.data,
  });

  CourseModel data;

  CourseDetailsResponseModel copyWith({
    CourseModel? data,
  }) =>
      CourseDetailsResponseModel(
        data: data ?? this.data,
      );

  factory CourseDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailsResponseModel(
        data: CourseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

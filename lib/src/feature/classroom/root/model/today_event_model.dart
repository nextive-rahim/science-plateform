import 'dart:convert';

import 'package:science_platform/src/feature/classroom/root/model/today_event_exam_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/models/video_model.dart';

TodayEventResponseModel todayEventResponseModelFromJson(String str) =>
    TodayEventResponseModel.fromJson(json.decode(str));

String todayEventResponseModelToJson(TodayEventResponseModel data) =>
    json.encode(data.toJson());

class TodayEventResponseModel {
  List<TodayEventModel> data;

  TodayEventResponseModel({
    required this.data,
  });

  factory TodayEventResponseModel.fromJson(Map<String, dynamic> json) =>
      TodayEventResponseModel(
        data: List<TodayEventModel>.from(
            json["data"].map((x) => TodayEventModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TodayEventModel {
  String slug;
  String title;
  String type;
  bool paid;
  DateTime availableFrom;
  Course course;
  VideoModel? video;
  TodayEventExamModel? exam;

  TodayEventModel({
    required this.slug,
    required this.title,
    required this.type,
    required this.paid,
    required this.availableFrom,
    required this.course,
    this.video,
    this.exam,
  });

  bool get isAvailableClass => DateTime.now().isAfter(availableFrom);

  factory TodayEventModel.fromJson(Map<String, dynamic> json) =>
      TodayEventModel(
        slug: json["slug"],
        title: json["title"],
        type: json["type"],
        paid: json["paid"],
        availableFrom: DateTime.parse(json["available_from"]),
        course: Course.fromJson(json["course"]),
        video:
            json["video"] == null ? null : VideoModel.fromJson(json["video"]),
        exam: json["exam"] == null
            ? null
            : TodayEventExamModel.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "type": type,
        "paid": paid,
        "available_from": availableFrom.toIso8601String(),
        "course": course.toJson(),
        "video": video?.toJson(),
        "exam": exam?.toJson(),
      };
}

class Course {
  int id;
  String title;
  String slug;
  SubscriptionStatusModel? subscriptionStatus;

  Course({
    required this.id,
    required this.title,
    required this.slug,
    required this.subscriptionStatus,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        subscriptionStatus: json["subscription_status"] == null
            ? null
            : SubscriptionStatusModel.fromJson(json["subscription_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "subscription_status": subscriptionStatus,
      };
}







// class HappeningTodayModel {
//   HappeningTodayModel({
//     this.lives,
//     this.exams,
//     this.writtenExams,
//   });

//   List<TodaysClassModel>? lives;
//   List<TodaysExamModel>? exams;
//   List<TodaysExamModel>? writtenExams;

//   HappeningTodayModel copyWith({
//     List<TodaysClassModel>? lives,
//     List<TodaysExamModel>? exams,
//     List<TodaysExamModel>? writtenExams,
//   }) =>
//       HappeningTodayModel(
//         lives: lives ?? this.lives,
//         exams: exams ?? this.exams,
//         writtenExams: writtenExams ?? this.writtenExams,
//       );

//   factory HappeningTodayModel.fromRawJson(String str) =>
//       HappeningTodayModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory HappeningTodayModel.fromJson(Map<String, dynamic> json) =>
//       HappeningTodayModel(
//         lives: json["lives"] == null
//             ? null
//             : List<TodaysClassModel>.from(
//                 json["lives"]?.map((x) => TodaysClassModel.fromJson(x))),
//         exams: json["exams"] == null
//             ? null
//             : List<TodaysExamModel>.from(
//                 json["exams"].map((x) => TodaysExamModel.fromJson(x))),
//         writtenExams: json["written_exams"] == null
//             ? []
//             : List<TodaysExamModel>.from(
//                 json["written_exams"]!.map((x) => TodaysExamModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "lives": lives == null
//             ? null
//             : List<dynamic>.from(lives!.map((x) => x.toJson())),
//         "exams": exams == null
//             ? null
//             : List<dynamic>.from(exams!.map((x) => x.toJson())),
//         "written_exams": writtenExams == null
//             ? []
//             : List<dynamic>.from(writtenExams!.map((x) => x.toJson())),
//       };
// }

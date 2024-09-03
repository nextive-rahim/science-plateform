import 'dart:convert';

import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';

class ExamResultModel {
  ExamResultModel({
    this.total,
    this.correct,
    this.submitted,
    this.wrong,
    this.totalMark,
    this.positiveMark,
    this.negativeMark,
    this.obtainedMark,
    this.startTime,
    this.endTime,
    this.subjects,
  });

  int? total;
  int? correct;
  int? submitted;
  int? wrong;
  dynamic totalMark;
  dynamic positiveMark;
  dynamic negativeMark;
  dynamic obtainedMark;
  DateTime? startTime;
  DateTime? endTime;
  List<int?>? subjects;

  ExamResultModel copyWith({
    int? total,
    int? correct,
    int? submitted,
    int? wrong,
    dynamic totalMark,
    dynamic positiveMark,
    dynamic negativeMark,
    dynamic obtainedMark,
    DateTime? startTime,
    DateTime? endTime,
    List<int?>? subjects,
  }) =>
      ExamResultModel(
        total: total ?? this.total,
        correct: correct ?? this.correct,
        submitted: submitted ?? this.submitted,
        wrong: wrong ?? this.wrong,
        totalMark: totalMark ?? this.totalMark,
        positiveMark: positiveMark ?? this.positiveMark,
        negativeMark: negativeMark ?? this.negativeMark,
        obtainedMark: obtainedMark ?? this.obtainedMark,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        subjects: subjects ?? this.subjects,
      );

  String get timeTaken {
    final difference = endTime.isNotNull
        ? endTime!.difference(startTime!)
        : const Duration(seconds: 0);

    String time = Duration(seconds: difference.inSeconds).formatToHMS;
    return time;
  }

  String get correctlyAnswered {
    String answered;
    answered = '${correct ?? 0}/${total ?? 0}';
    return answered;
  }

  String get yourResult {
    String result;
    result = '${obtainedMark ?? 0}';
    return result;
  }

  factory ExamResultModel.fromRawJson(String str) =>
      ExamResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      ExamResultModel(
        total: json["total"],
        correct: json["correct"],
        submitted: json["submitted"],
        wrong: json["wrong"],
        totalMark: json["total_mark"],
        positiveMark: json["positive_mark"],
        negativeMark: json["negative_mark"],
        obtainedMark: json["obtained_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        subjects: json["subjects"] == null
            ? []
            : List<int>.from(json["subjects"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "correct": correct,
        "submitted": submitted,
        "wrong": wrong,
        "total_mark": totalMark,
        "positive_mark": positiveMark,
        "negative_mark": negativeMark,
        "obtained_mark": obtainedMark,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "subjects": List<dynamic>.from(subjects!.map((x) => x)),
      };
}

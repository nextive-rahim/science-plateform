import 'package:science_platform/src/utils/extensions/string_extension.dart';
import 'package:science_platform/src/utils/text_constants.dart';

class TodayEventExamModel {
  int? id;
  String? title;
  int? totalMarks;
  int? passMarks;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  int? duration;
  bool? submitted;

  TodayEventExamModel({
    this.id,
    this.title,
    this.totalMarks,
    this.passMarks,
    this.startTime,
    this.endTime,
    this.resultPublishTime,
    this.duration,
    this.submitted,
  });
  bool get isExamNotAvaiable => DateTime.now().isBefore(startTime!);
  bool get isExamExpired => DateTime.now().isAfter(endTime!);
  bool get isAvailableExam =>
      DateTime.now().isAfter(startTime!) && DateTime.now().isBefore(endTime!);
  String get getExamButtonTitle {
    String buttonTitle;
    if (isAvailableExam) {
      buttonTitle = TextConstants.joinExam;
    } else if (isExamExpired) {
      buttonTitle = TextConstants.examEndTime;
    } else {
      buttonTitle = getFormattedTime(startTime)!;
    }
    return buttonTitle;
  }

  factory TodayEventExamModel.fromJson(Map<String, dynamic> json) =>
      TodayEventExamModel(
        id: json["id"],
        title: json["title"],
        totalMarks: json["total_marks"],
        passMarks: json["pass_marks"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        resultPublishTime: DateTime.parse(json["result_publish_time"]),
        duration: json["duration"],
        submitted: json["submitted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "total_marks": totalMarks,
        "pass_marks": passMarks,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "result_publish_time": resultPublishTime!.toIso8601String(),
        "duration": duration,
        "submitted": submitted,
      };
}

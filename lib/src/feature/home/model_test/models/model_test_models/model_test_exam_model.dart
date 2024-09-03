import 'dart:convert';

import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_mcq_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_result_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class ModelTestExamResponseData {
  ModelTestExamResponseData({
    this.data,
  });

  ModelTestExamModel? data;

  ModelTestExamResponseData copyWith({
    ModelTestExamModel? data,
  }) =>
      ModelTestExamResponseData(
        data: data ?? this.data,
      );

  factory ModelTestExamResponseData.fromRawJson(String str) =>
      ModelTestExamResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelTestExamResponseData.fromJson(Map<String, dynamic> json) =>
      ModelTestExamResponseData(
        data: json["data"] == null
            ? null
            : ModelTestExamModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ModelTestExamModel {
  ModelTestExamModel({
    this.id,
    this.contentId,
    this.mode,
    this.duration,
    this.perQuestionMark,
    this.negativeMark,
    this.passMark,
    this.strict,
    this.startTime,
    this.endTime,
    this.resultPublishTime,
    this.totalSubject,
    this.retryLimit,
    this.totalQuestions,
    this.mcqs,
    this.mcqCount,
    this.result,
    this.subjects,
  });

  int? id;
  int? contentId;
  String? mode;
  int? duration;
  String? perQuestionMark;
  String? negativeMark;
  String? passMark;
  bool? strict;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  int? totalSubject;
  dynamic retryLimit;
  int? totalQuestions;
  List<ExamMcqModel?>? mcqs;
  int? mcqCount;
  ExamResultModel? result;
  List<GroupExamSubjectModel>? subjects;

  ModelTestExamModel copyWith({
    int? id,
    int? contentId,
    String? mode,
    int? duration,
    String? perQuestionMark,
    String? negativeMark,
    String? passMark,
    bool? strict,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? resultPublishTime,
    int? totalSubject,
    dynamic retryLimit,
    int? totalQuestions,
    List<ExamMcqModel?>? mcqs,
    int? mcqCount,
    ExamResultModel? result,
    List<GroupExamSubjectModel>? subjects,
  }) =>
      ModelTestExamModel(
        id: id ?? this.id,
        contentId: contentId ?? this.contentId,
        mode: mode ?? this.mode,
        duration: duration ?? this.duration,
        perQuestionMark: perQuestionMark ?? this.perQuestionMark,
        negativeMark: negativeMark ?? this.negativeMark,
        passMark: passMark ?? this.passMark,
        strict: strict ?? this.strict,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        resultPublishTime: resultPublishTime ?? this.resultPublishTime,
        totalSubject: totalSubject ?? this.totalSubject,
        retryLimit: retryLimit ?? this.retryLimit,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        mcqs: mcqs ?? this.mcqs,
        mcqCount: mcqCount ?? this.mcqCount,
        result: result ?? this.result,
        subjects: subjects ?? this.subjects,
      );

  bool get resultIsPublished {
    bool published = true;
    if (mode != ExamType.practice.name) {
      published = resultPublishTime.isNotNull
          ? resultPublishTime!.isBefore(DateTime.now())
          : false;
    }
    return published;
  }

  bool get didNotAttend {
    bool didNot = false;
    bool endTimePassed = endTime!.isBefore(DateTime.now());

    if (mode != ExamType.practice.name) {
      didNot = endTime?.isBefore(DateTime.now()) ?? false;
      if (resultIsPublished && result == null) {
        didNot = true;
      } else if (endTimePassed && result == null) {
        didNot = true;
      } else if ((endTimePassed || resultIsPublished) &&
          result?.endTime == null &&
          result?.submitted == 0 &&
          result?.negativeMark == null) {
        didNot = true;
      }
    }
    return didNot;
  }

  factory ModelTestExamModel.fromRawJson(String str) =>
      ModelTestExamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelTestExamModel.fromJson(Map<String, dynamic> json) =>
      ModelTestExamModel(
        id: json["id"],
        contentId: json["content_id"],
        mode: json["mode"],
        duration: json["duration"],
        perQuestionMark: json["per_question_mark"],
        negativeMark: json["negative_mark"],
        passMark: json["pass_mark"],
        strict: json["strict"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]).toLocal(),
        endTime: json["end_time"] == null
            ? null
            : DateTime.parse(json["end_time"]).toLocal(),
        resultPublishTime: json["result_publish_time"] == null
            ? null
            : DateTime.parse(json["result_publish_time"]).toLocal(),
        totalSubject: json["total_subject"],
        retryLimit: json["retry_limit"],
        totalQuestions: json["total_questions"],
        mcqs: json["mcqs"] == null
            ? null
            : List<ExamMcqModel>.from(
                json["mcqs"].map((x) => ExamMcqModel.fromJson(x))),
        mcqCount: json["mcq_count"],
        result: json["result"] == null
            ? null
            : ExamResultModel.fromJson(json["result"]),
        subjects: json["subjects"] == null
            ? null
            : List<GroupExamSubjectModel>.from(
                json["subjects"].map((x) => GroupExamSubjectModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "mode": mode,
        "duration": duration,
        "per_question_mark": perQuestionMark,
        "negative_mark": negativeMark,
        "pass_mark": passMark,
        "strict": strict,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "result_publish_time": resultPublishTime?.toIso8601String(),
        "total_subject": totalSubject,
        "retry_limit": retryLimit,
        "total_questions": totalQuestions,
        "mcqs": mcqs == null
            ? null
            : List<dynamic>.from(mcqs!.map((x) => x?.toJson())),
        "mcq_count": mcqCount,
        "result": result?.toJson(),
        "subjects": subjects == null
            ? null
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_mcq_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/exam_result_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/group_exam_subject_model.dart';
import 'package:science_platform/src/utils/enums.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class ExamModel {
  ExamModel({
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

  bool get isPracticeExam => mode == ExamType.practice.name;

  bool get isGroupExam => mode == ExamType.group.name;

  bool get isExamAttended => result.isNotNull;

  bool get examHasNotStarted => startTime!.isAfter(DateTime.now());

  bool get isTimeOver => endTime!.isBefore(DateTime.now());

  bool get isExamAvailable => !isExamAttended && !isTimeOver;

  bool get isResultPublished {
    if (mode != ExamType.practice.name) {
      return resultPublishTime.isNotNull
          ? resultPublishTime!.isBefore(DateTime.now())
          : false;
    }
    return true;
  }

  ExamModel copyWith({
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
      ExamModel(
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

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
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

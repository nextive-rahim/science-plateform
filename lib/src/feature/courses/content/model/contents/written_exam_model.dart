import 'dart:convert';

import 'package:science_platform/src/feature/courses/content/model/content_model.dart';
import 'package:science_platform/src/feature/profile/model/user_model.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';

class WrittenExamResponseModel {
  WrittenExamResponseModel({
    this.data,
  });

  WrittenExamModel? data;

  WrittenExamResponseModel copyWith({
    WrittenExamModel? data,
  }) =>
      WrittenExamResponseModel(
        data: data ?? this.data,
      );

  factory WrittenExamResponseModel.fromRawJson(String str) =>
      WrittenExamResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WrittenExamResponseModel.fromJson(Map<String, dynamic> json) =>
      WrittenExamResponseModel(
        data: json["data"] == null
            ? null
            : WrittenExamModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class WrittenExamModel {
  WrittenExamModel({
    this.id,
    this.contentId,
    this.title,
    this.slug,
    this.mode,
    this.duration,
    this.description,
    this.passMark,
    this.strict,
    this.startTime,
    this.endTime,
    this.resultPublishTime,
    this.retryLimit,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.attended,
    this.submitted,
    this.questions,
    this.result,
    this.content,
  });

  int? id;
  int? contentId;
  dynamic title;
  dynamic slug;
  String? mode;
  int? duration;
  String? description;
  dynamic passMark;
  bool? strict;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? resultPublishTime;
  int? retryLimit;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? attended;
  bool? submitted;
  List<WrittenExamQuestionModel>? questions;
  WrittenExamResultModel? result;
  ContentModel? content;

  bool get isExamAttended => result.isNotNull;

  bool get examHasNotStarted =>
      startTime == null ? false : startTime!.isAfter(DateTime.now());

  bool get isTimeOver =>
      endTime == null ? false : endTime!.isBefore(DateTime.now());

  bool get isExamAvailable =>
      !isExamAttended && !isTimeOver && !examHasNotStarted;

  bool get isResultPublished {
    return resultPublishTime.isNotNull
        ? resultPublishTime!.isBefore(DateTime.now())
        : false;
  }

  WrittenExamModel copyWith({
    int? id,
    int? contentId,
    dynamic title,
    dynamic slug,
    String? mode,
    int? duration,
    String? description,
    dynamic passMark,
    bool? strict,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? resultPublishTime,
    int? retryLimit,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? attended,
    bool? submitted,
    List<WrittenExamQuestionModel>? questions,
    WrittenExamResultModel? result,
    ContentModel? content,
  }) =>
      WrittenExamModel(
        id: id ?? this.id,
        contentId: contentId ?? this.contentId,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        mode: mode ?? this.mode,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        passMark: passMark ?? this.passMark,
        strict: strict ?? this.strict,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        resultPublishTime: resultPublishTime ?? this.resultPublishTime,
        retryLimit: retryLimit ?? this.retryLimit,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        attended: attended ?? this.attended,
        submitted: submitted ?? this.submitted,
        questions: questions ?? this.questions,
        result: result ?? this.result,
        content: content ?? this.content,
      );

  factory WrittenExamModel.fromRawJson(String str) =>
      WrittenExamModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WrittenExamModel.fromJson(Map<String, dynamic> json) =>
      WrittenExamModel(
        id: json["id"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        mode: json["mode"],
        duration: json["duration"] ?? 0,
        description: json["description"],
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
        retryLimit: json["retry_limit"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        attended: json["attended"],
        submitted: json["submitted"],
        questions: json["questions"] == null
            ? null
            : List<WrittenExamQuestionModel>.from(json["questions"]
                .map((x) => WrittenExamQuestionModel.fromJson(x))),
        result: json["result"] == null
            ? null
            : WrittenExamResultModel.fromJson(json["result"]),
        content: json["content"] == null
            ? null
            : ContentModel.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "mode": mode,
        "duration": duration,
        "description": description,
        "pass_mark": passMark,
        "strict": strict,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "result_publish_time": resultPublishTime?.toIso8601String(),
        "retry_limit": retryLimit,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "attended": attended,
        "submitted": submitted,
        "questions": questions == null
            ? null
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "result": result?.toJson(),
        "content": content?.toJson(),
      };
}

class WrittenExamQuestionModel {
  WrittenExamQuestionModel({
    this.id,
    this.createdBy,
    this.type,
    this.text,
    this.photo,
    this.mediaLink,
    this.mark,
    this.difficultyLevel,
    this.questionableType,
    this.questionableId,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.users,
  });

  int? id;
  dynamic createdBy;
  String? type;
  String? text;
  dynamic photo;
  String? mediaLink;
  String? mark;
  dynamic difficultyLevel;
  String? questionableType;
  int? questionableId;
  int? active;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  WrittenExamPivot? pivot;
  List<dynamic>? users;

  WrittenExamQuestionModel copyWith({
    int? id,
    dynamic createdBy,
    String? type,
    String? text,
    dynamic photo,
    String? mediaLink,
    String? mark,
    dynamic difficultyLevel,
    String? questionableType,
    int? questionableId,
    int? active,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    WrittenExamPivot? pivot,
    List<dynamic>? users,
  }) =>
      WrittenExamQuestionModel(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        type: type ?? this.type,
        text: text ?? this.text,
        photo: photo ?? this.photo,
        mediaLink: mediaLink ?? this.mediaLink,
        mark: mark ?? this.mark,
        difficultyLevel: difficultyLevel ?? this.difficultyLevel,
        questionableType: questionableType ?? this.questionableType,
        questionableId: questionableId ?? this.questionableId,
        active: active ?? this.active,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
        users: users ?? this.users,
      );

  factory WrittenExamQuestionModel.fromRawJson(String str) =>
      WrittenExamQuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WrittenExamQuestionModel.fromJson(Map<String, dynamic> json) =>
      WrittenExamQuestionModel(
        id: json["id"],
        createdBy: json["created_by"],
        type: json["type"],
        text: json["text"],
        photo: json["photo"],
        mediaLink: json["media_link"],
        mark: json["mark"],
        difficultyLevel: json["difficulty_level"],
        questionableType: json["questionable_type"],
        questionableId: json["questionable_id"],
        active: json["active"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null
            ? null
            : WrittenExamPivot.fromJson(json["pivot"]),
        users: json["users"] == null
            ? null
            : List<dynamic>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "type": type,
        "text": text,
        "photo": photo,
        "media_link": mediaLink,
        "mark": mark,
        "difficulty_level": difficultyLevel,
        "questionable_type": questionableType,
        "questionable_id": questionableId,
        "active": active,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
        "users":
            users == null ? null : List<dynamic>.from(users!.map((x) => x)),
      };
}

class WrittenExamPivot {
  WrittenExamPivot({
    this.writtenExamId,
    this.questionId,
  });

  int? writtenExamId;
  int? questionId;

  WrittenExamPivot copyWith({
    int? writtenExamId,
    int? questionId,
  }) =>
      WrittenExamPivot(
        writtenExamId: writtenExamId ?? this.writtenExamId,
        questionId: questionId ?? this.questionId,
      );

  factory WrittenExamPivot.fromRawJson(String str) =>
      WrittenExamPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WrittenExamPivot.fromJson(Map<String, dynamic> json) =>
      WrittenExamPivot(
        writtenExamId: json["written_exam_id"],
        questionId: json["question_id"],
      );

  Map<String, dynamic> toJson() => {
        "written_exam_id": writtenExamId,
        "question_id": questionId,
      };
}

class WrittenExamResultModel {
  WrittenExamResultModel({
    this.id,
    this.writtenExamId,
    this.userId,
    this.total,
    this.correct,
    this.wrong,
    this.totalMark,
    this.positiveMark,
    this.obtainedMark,
    this.previousObtainedMark,
    this.highestObtainedMark,
    this.startTime,
    this.endTime,
    this.duration,
    this.submitted,
    this.totalTried,
    this.status,
    this.grade,
    this.point,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pdfLink,
    this.markedPdfLink,
    this.user,
  });

  int? id;
  int? writtenExamId;
  int? userId;
  dynamic total;
  dynamic correct;
  dynamic wrong;
  String? totalMark;
  dynamic positiveMark;
  String? obtainedMark;
  dynamic previousObtainedMark;
  dynamic highestObtainedMark;
  DateTime? startTime;
  DateTime? endTime;
  dynamic duration;
  bool? submitted;
  dynamic totalTried;
  String? status;
  dynamic grade;
  dynamic point;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pdfLink;
  String? markedPdfLink;
  UserModel? user;

  WrittenExamResultModel copyWith({
    int? id,
    int? writtenExamId,
    int? userId,
    dynamic total,
    dynamic correct,
    dynamic wrong,
    String? totalMark,
    dynamic positiveMark,
    String? obtainedMark,
    dynamic previousObtainedMark,
    dynamic highestObtainedMark,
    DateTime? startTime,
    DateTime? endTime,
    dynamic duration,
    bool? submitted,
    dynamic totalTried,
    String? status,
    dynamic grade,
    dynamic point,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? pdfLink,
    String? markedPdfLink,
    UserModel? user,
  }) =>
      WrittenExamResultModel(
        id: id ?? this.id,
        writtenExamId: writtenExamId ?? this.writtenExamId,
        userId: userId ?? this.userId,
        total: total ?? this.total,
        correct: correct ?? this.correct,
        wrong: wrong ?? this.wrong,
        totalMark: totalMark ?? this.totalMark,
        positiveMark: positiveMark ?? this.positiveMark,
        obtainedMark: obtainedMark ?? this.obtainedMark,
        previousObtainedMark: previousObtainedMark ?? this.previousObtainedMark,
        highestObtainedMark: highestObtainedMark ?? this.highestObtainedMark,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        duration: duration ?? this.duration,
        submitted: submitted ?? this.submitted,
        totalTried: totalTried ?? this.totalTried,
        status: status ?? this.status,
        grade: grade ?? this.grade,
        point: point ?? this.point,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pdfLink: pdfLink ?? this.pdfLink,
        markedPdfLink: markedPdfLink ?? this.markedPdfLink,
        user: user ?? this.user,
      );

  factory WrittenExamResultModel.fromRawJson(String str) =>
      WrittenExamResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WrittenExamResultModel.fromJson(Map<String, dynamic> json) =>
      WrittenExamResultModel(
        id: json["id"],
        writtenExamId: json["written_exam_id"],
        userId: json["user_id"],
        total: json["total"],
        correct: json["correct"],
        wrong: json["wrong"],
        totalMark: json["total_mark"],
        positiveMark: json["positive_mark"],
        obtainedMark: json["obtained_mark"],
        previousObtainedMark: json["previous_obtained_mark"],
        highestObtainedMark: json["highest_obtained_mark"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]).toLocal(),
        endTime: json["end_time"] == null
            ? null
            : DateTime.parse(json["end_time"]).toLocal(),
        duration: json["duration"],
        submitted: json["submitted"],
        totalTried: json["total_tried"],
        status: json["status"],
        grade: json["grade"],
        point: json["point"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pdfLink: json["pdf_link"],
        markedPdfLink: json["marked_pdf_link"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "written_exam_id": writtenExamId,
        "user_id": userId,
        "total": total,
        "correct": correct,
        "wrong": wrong,
        "total_mark": totalMark,
        "positive_mark": positiveMark,
        "obtained_mark": obtainedMark,
        "previous_obtained_mark": previousObtainedMark,
        "highest_obtained_mark": highestObtainedMark,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "duration": duration,
        "submitted": submitted,
        "total_tried": totalTried,
        "status": status,
        "grade": grade,
        "point": point,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pdf_link": pdfLink,
        "marked_pdf_link": markedPdfLink,
        "user": user?.toJson(),
      };
}

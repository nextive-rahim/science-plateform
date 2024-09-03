import 'dart:convert';

import 'package:science_platform/src/feature/courses/content/model/contents/contents_b.dart';
import 'package:science_platform/src/models/video_model.dart';
import 'package:science_platform/src/utils/extensions/string_extension.dart';

class ContentModel {
  ContentModel({
    this.id,
    this.contentableType,
    this.contentableId,
    this.contentId,
    this.clearance,
    this.title,
    this.slug,
    this.description,
    this.createdBy,
    this.type,
    this.duration,
    this.photo,
    this.order,
    this.canPreview,
    this.paid,
    this.active,
    this.availableAt,
    this.smsToAll,
    this.smsToPresent,
    this.smsToAbsent,
    this.pdf,
    this.video,
    this.note,
    this.live,
    this.link,
    this.testmoj,
    this.exam,
    this.writtenExam,
    this.assignment,
  });

  int? id;
  String? contentableType;
  int? contentableId;
  dynamic contentId;
  Clearance? clearance;
  String? title;
  String? slug;
  dynamic description;
  dynamic createdBy;
  String? type;
  dynamic duration;
  dynamic photo;
  int? order;
  bool? canPreview;
  bool? paid;
  bool? active;
  DateTime? availableAt;
  bool? smsToAll;
  int? smsToPresent;
  int? smsToAbsent;
  PdfModel? pdf;
  VideoModel? video;
  NoteModel? note;
  LiveModel? live;
  LinkModel? link;
  TestmojModel? testmoj;
  ExamModel? exam;
  WrittenExamModel? writtenExam;
  AssignmentModel? assignment;

  ContentModel copyWith({
    int? id,
    String? contentableType,
    int? contentableId,
    dynamic contentId,
    Clearance? clearance,
    String? title,
    String? slug,
    dynamic description,
    dynamic createdBy,
    String? type,
    dynamic duration,
    dynamic photo,
    int? order,
    bool? canPreview,
    bool? paid,
    bool? active,
    DateTime? availableFrom,
    bool? smsToAll,
    int? smsToPresent,
    int? smsToAbsent,
    PdfModel? pdf,
    VideoModel? video,
    NoteModel? note,
    LiveModel? live,
    LinkModel? link,
    TestmojModel? testmoj,
    ExamModel? exam,
    WrittenExamModel? writtenExam,
    AssignmentModel? assignment,
  }) =>
      ContentModel(
        id: id ?? this.id,
        contentableType: contentableType ?? this.contentableType,
        contentableId: contentableId ?? this.contentableId,
        contentId: contentId ?? this.contentId,
        clearance: clearance ?? this.clearance,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        photo: photo ?? this.photo,
        order: order ?? this.order,
        canPreview: canPreview ?? this.canPreview,
        paid: paid ?? this.paid,
        active: active ?? this.active,
        availableAt: availableFrom ?? availableAt,
        smsToAll: smsToAll ?? this.smsToAll,
        smsToPresent: smsToPresent ?? this.smsToPresent,
        smsToAbsent: smsToAbsent ?? this.smsToAbsent,
        pdf: pdf ?? this.pdf,
        video: video ?? this.video,
        note: note ?? this.note,
        live: live ?? this.live,
        link: link ?? this.link,
        testmoj: testmoj ?? this.testmoj,
        exam: exam ?? this.exam,
        writtenExam: writtenExam ?? this.writtenExam,
        assignment: assignment ?? this.assignment,
      );

  bool get contentIsNotAvailable =>
      (availableAt == null ? false : DateTime.now().isBefore(availableAt!));

  String get contentStatus {
    String status;
    if (contentIsNotAvailable) {
      status = availableAt == null ? '' : getFormattedDateTime(availableAt)!;
    } else {
      status = '';
    }
    return status;
  }

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        contentableType: json["contentable_type"],
        contentableId: json["contentable_id"],
        contentId: json["content_id"],
        clearance: json["clearance"] == null
            ? null
            : Clearance.fromJson(json["clearance"]),
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        createdBy: json["created_by"],
        type: json["type"],
        duration: json["duration"] ?? 0,
        photo: json["photo"],
        order: json["order"],
        canPreview: json["can_preview"],
        paid: json["paid"],
        active: json["active"] ?? false,
        availableAt: json["available_from"] == null
            ? null
            : DateTime.parse(json["available_from"]),
        smsToAll: json["sms_to_all"],
        smsToPresent: json["sms_to_present"],
        smsToAbsent: json["sms_to_absent"],
        pdf: json["pdf"] == null ? null : PdfModel.fromJson(json["pdf"]),
        video:
            json["video"] == null ? null : VideoModel.fromJson(json["video"]),
        note: json["note"] == null ? null : NoteModel.fromJson(json["note"]),
        live: json["live"] == null ? null : LiveModel.fromJson(json["live"]),
        link: json["link"] == null ? null : LinkModel.fromJson(json["link"]),
        testmoj: json["testmoj"] == null
            ? null
            : TestmojModel.fromJson(json["testmoj"]),
        exam: json["exam"] == null ? null : ExamModel.fromJson(json["exam"]),
        writtenExam: json["written_exam"] == null
            ? null
            : WrittenExamModel.fromJson(json["written_exam"]),
        assignment: json["assignment"] == null
            ? null
            : AssignmentModel.fromJson(json["assignment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentable_type": contentableType,
        "contentable_id": contentableId,
        "content_id": contentId,
        "clearance": clearance?.toJson(),
        "title": title,
        "slug": slug,
        "description": description,
        "created_by": createdBy,
        "type": type,
        "duration": duration,
        "photo": photo,
        "order": order,
        "can_preview": canPreview,
        "paid": paid,
        "active": active,
        "available_from": availableAt?.toIso8601String(),
        "sms_to_all": smsToAll,
        "sms_to_present": smsToPresent,
        "sms_to_absent": smsToAbsent,
        "pdf": pdf?.toJson(),
        "video": video?.toJson(),
        "note": note?.toJson(),
        "live": live?.toJson(),
        "link": link?.toJson(),
        "testmoj": testmoj?.toJson(),
        "exam": exam?.toJson(),
        "written_exam": writtenExam?.toJson(),
        "assignment": assignment?.toJson(),
      };
}

class Clearance {
  Clearance({
    this.allow,
    this.item,
  });

  bool? allow;
  Item? item;

  Clearance copyWith({
    bool? allow,
    Item? item,
  }) =>
      Clearance(
        allow: allow ?? this.allow,
        item: item ?? this.item,
      );

  factory Clearance.fromRawJson(String str) =>
      Clearance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Clearance.fromJson(Map<String, dynamic> json) => Clearance(
        allow: json["allow"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "allow": allow,
        "item": item?.toJson(),
      };
}

class Item {
  Item({
    this.id,
    this.title,
    this.examId,
  });

  int? id;
  String? title;
  int? examId;

  Item copyWith({
    int? id,
    String? title,
    int? examId,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        examId: examId ?? this.examId,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"] ?? '',
        examId: json["exam_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "exam_id": examId,
      };
}

class TestmojModel {
  TestmojModel({
    this.id,
    this.createdBy,
    this.contentId,
    this.title,
    this.slug,
    this.examLink,
    this.resultLink,
    this.duration,
    this.description,
    this.startTime,
    this.resultPublishTime,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic createdBy;
  int? contentId;
  dynamic title;
  dynamic slug;
  String? examLink;
  String? resultLink;
  dynamic duration;
  dynamic description;
  DateTime? startTime;
  DateTime? resultPublishTime;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  TestmojModel copyWith({
    int? id,
    dynamic createdBy,
    int? contentId,
    dynamic title,
    dynamic slug,
    String? examLink,
    String? resultLink,
    dynamic duration,
    dynamic description,
    DateTime? startTime,
    DateTime? resultPublishTime,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TestmojModel(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        contentId: contentId ?? this.contentId,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        examLink: examLink ?? this.examLink,
        resultLink: resultLink ?? this.resultLink,
        duration: duration ?? this.duration,
        description: description ?? this.description,
        startTime: startTime ?? this.startTime,
        resultPublishTime: resultPublishTime ?? this.resultPublishTime,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TestmojModel.fromJson(Map<String, dynamic> json) => TestmojModel(
        id: json["id"],
        createdBy: json["created_by"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        examLink: json["exam_link"],
        resultLink: json["result_link"],
        duration: json["duration"],
        description: json["description"],
        startTime: DateTime.parse(json["start_time"]),
        resultPublishTime: DateTime.parse(json["result_publish_time"]),
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "exam_link": examLink,
        "result_link": resultLink,
        "duration": duration,
        "description": description,
        "start_time": startTime?.toIso8601String(),
        "result_publish_time": resultPublishTime?.toIso8601String(),
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

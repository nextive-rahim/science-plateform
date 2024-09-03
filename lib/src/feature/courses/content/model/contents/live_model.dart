import 'package:science_platform/src/utils/extensions/string_extension.dart';

class LiveModel {
  LiveModel({
    this.id,
    this.contentId,
    this.title,
    this.slug,
    this.startTime,
    this.endTime,
    this.link,
    this.source,
  });

  int? id;
  int? contentId;
  String? title;
  dynamic slug;
  DateTime? startTime;
  DateTime? endTime;
  String? link;
  String? source;

  LiveModel copyWith({
    int? id,
    int? contentId,
    String? title,
    dynamic slug,
    DateTime? startTime,
    DateTime? endTime,
    String? link,
    String? source,
  }) =>
      LiveModel(
        id: id ?? this.id,
        contentId: contentId ?? this.contentId,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        link: link ?? this.link,
        source: source ?? this.source,
      );

  bool get liveContentIsNotAvailable =>
      (startTime == null ? false : DateTime.now().isBefore(startTime!));

  String get liveContentStatus {
    String status;
    if (liveContentIsNotAvailable) {
      status = startTime == null ? '' : getFormattedDateTime(startTime)!;
    } else {
      status = '';
    }
    return status;
  }

  factory LiveModel.fromJson(Map<String, dynamic> json) => LiveModel(
        id: json["id"],
        contentId: json["content_id"],
        title: json["title"],
        slug: json["slug"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        link: json["link"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content_id": contentId,
        "title": title,
        "slug": slug,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "link": link,
        "source": source,
      };
}

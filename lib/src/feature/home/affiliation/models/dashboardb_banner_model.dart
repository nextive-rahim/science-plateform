import 'dart:convert';

DashBoardBannerResponseModel dashBoardBannerResponseModelFromJson(
        String? str) =>
    DashBoardBannerResponseModel.fromJson(json.decode(str!));

String? dashBoardBannerResponseModelToJson(DashBoardBannerResponseModel data) =>
    json.encode(data.toJson());

class DashBoardBannerResponseModel {
  DashBoardBannerResponseModel({
    this.data,
  });

  DashbaordBannerData? data;

  factory DashBoardBannerResponseModel.fromJson(Map<String?, dynamic> json) =>
      DashBoardBannerResponseModel(
        data: DashbaordBannerData.fromJson(json["data"]),
      );

  Map<String?, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class DashbaordBannerData {
  DashbaordBannerData({
    this.id,
    this.userId,
    this.approvedBy,
    this.title,
    this.slug,
    this.body,
    this.photo,
    this.order,
    this.active,
    this.type,
    this.createdAt,
  });

  int? id;
  dynamic userId;
  dynamic approvedBy;
  String? title;
  String? slug;
  String? body;
  String? photo;
  int? order;
  bool? active;
  String? type;
  DateTime? createdAt;

  String get notice => body ?? '';

  factory DashbaordBannerData.fromJson(Map<String?, dynamic> json) =>
      DashbaordBannerData(
        id: json["id"],
        userId: json["user_id"],
        approvedBy: json["approved_by"],
        title: json["title"],
        slug: json["slug"],
        body: json["body"],
        photo: json["photo"],
        order: json["order"],
        active: json["active"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "approved_by": approvedBy,
        "title": title,
        "slug": slug,
        "body": body,
        "photo": photo,
        "order": order,
        "active": active,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
      };
}

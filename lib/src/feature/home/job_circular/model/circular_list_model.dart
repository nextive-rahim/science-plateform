import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:science_platform/src/models/image_model.dart';

CircularResponseModel circularDetailsResponseModelFromJson(String str) =>
    CircularResponseModel.fromJson(json.decode(str));

String circularDetailsResponseModelToJson(CircularResponseModel data) =>
    json.encode(data.toJson());

class CircularResponseModel {
  JobCircular? jobCircular;

  CircularResponseModel({
    this.jobCircular,
  });

  factory CircularResponseModel.fromJson(Map<String, dynamic> json) =>
      CircularResponseModel(
        jobCircular: JobCircular.fromJson(json["jobCircular"]),
      );

  Map<String, dynamic> toJson() => {
        "jobCircular": jobCircular!.toJson(),
      };
}

class JobCircular {
  int? currentPage;
  List<JobCircularModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  JobCircular({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory JobCircular.fromJson(Map<String, dynamic> json) => JobCircular(
        currentPage: json["current_page"],
        data: List<JobCircularModel>.from(
            json["data"].map((x) => JobCircularModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class JobCircularModel {
  int? id;
  String? title;
  dynamic createdBy;
  String? slug;
  String? description;
  dynamic reference;
  DateTime? publishDate;
  dynamic expireDate;
  int? order;
  int? active;
  dynamic about;
  String? jobTitle;
  String? vacancy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? categories;
  ImageModel? image;

  JobCircularModel({
    this.id,
    this.title,
    this.createdBy,
    this.slug,
    this.description,
    this.reference,
    this.publishDate,
    this.expireDate,
    this.order,
    this.active,
    this.about,
    this.jobTitle,
    this.vacancy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.image,
  });
  String? get date =>
      createdAt != null ? DateFormat.yMMMMd().format(createdAt!) : null;

  String? get time =>
      createdAt != null ? DateFormat.jm().format(createdAt!) : null;
  factory JobCircularModel.fromJson(Map<String, dynamic> json) =>
      JobCircularModel(
        id: json["id"],
        title: json["title"],
        createdBy: json["created_by"],
        slug: json["slug"],
        description: json["description"],
        reference: json["reference"],
        publishDate: DateTime.parse(json["publish_date"]),
        expireDate: json["expire_date"],
        about: json["about"],
        jobTitle: json["job_title"],
        vacancy: json["vacancy"],
        order: json["order"],
        active: json["active"],
        categories: json["categories"] == null
            ? []
            : List<int>.from(json["categories"].map((x) => x)),
        image: ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_by": createdBy,
        "slug": slug,
        "description": description,
        "reference": reference,
        "publish_date": publishDate!.toIso8601String(),
        "expire_date": expireDate,
        "order": order,
        "active": active,
        "about": about,
        "job_title": jobTitle,
        "vacancy": vacancy,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "image": image!.toJson(),
      };
}

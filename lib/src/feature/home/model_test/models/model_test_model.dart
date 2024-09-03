import 'dart:convert';

import 'package:science_platform/src/feature/courses/root/model/category_model.dart';
import 'package:science_platform/src/feature/courses/root/model/course_model.dart';
import 'package:science_platform/src/feature/home/model_test/models/model_test_models/model_test_exam_model.dart';

class ModelTestResponseData {
  ModelTestResponseData({
    this.data,
  });

  List<CourseModel>? data;

  ModelTestResponseData copyWith({
    List<CourseModel>? data,
  }) =>
      ModelTestResponseData(
        data: data ?? this.data,
      );

  factory ModelTestResponseData.fromRawJson(String str) =>
      ModelTestResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelTestResponseData.fromJson(Map<String, dynamic> json) =>
      ModelTestResponseData(
        data: json["data"] == null
            ? null
            : List<CourseModel>.from(
                json["data"].map((x) => CourseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ModelTestModel {
  ModelTestModel({
    this.id,
    this.title,
    this.slug,
    this.photo,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.order,
    this.active,
    this.isSubscribed,
    this.categories,
    this.contents,
  });

  int? id;
  String? title;
  String? slug;
  dynamic photo;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  dynamic order;
  bool? active;
  bool? isSubscribed;
  List<CategoryModel>? categories;
  List<ModelTestContentModel>? contents;

  ModelTestModel copyWith({
    int? id,
    String? title,
    String? slug,
    dynamic photo,
    dynamic price,
    dynamic discount,
    dynamic discountTill,
    dynamic discountedPrice,
    dynamic order,
    bool? active,
    bool? isSubscribed,
    List<CategoryModel>? categories,
    List<ModelTestContentModel>? contents,
  }) =>
      ModelTestModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        photo: photo ?? this.photo,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        discountTill: discountTill ?? this.discountTill,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        order: order ?? this.order,
        active: active ?? this.active,
        isSubscribed: isSubscribed ?? this.isSubscribed,
        categories: categories ?? this.categories,
        contents: contents ?? this.contents,
      );

  factory ModelTestModel.fromRawJson(String str) =>
      ModelTestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelTestModel.fromJson(Map<String, dynamic> json) => ModelTestModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        photo: json["photo"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        order: json["order"],
        active: json["active"],
        isSubscribed: json["is_subscribed"],
        categories: json["categories"] == null
            ? null
            : List<CategoryModel>.from(
                json["categories"].map((x) => CategoryModel.fromJson(x))),
        contents: json["contents"] == null
            ? null
            : List<ModelTestContentModel>.from(
                json["contents"].map((x) => ModelTestContentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "photo": photo,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "order": order,
        "active": active,
        "is_subscribed": isSubscribed,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "contents": (contents == null || contents!.isEmpty)
            ? null
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class ModelTestContentModel {
  ModelTestContentModel({
    this.id,
    this.contentableType,
    this.contentableId,
    this.contentId,
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
    this.exam,
  });

  int? id;
  String? contentableType;
  int? contentableId;
  dynamic contentId;
  String? title;
  String? slug;
  dynamic description;
  dynamic createdBy;
  String? type;
  String? duration;
  dynamic photo;
  int? order;
  bool? canPreview;
  bool? paid;
  bool? active;
  DateTime? availableAt;
  bool? smsToAll;
  int? smsToPresent;
  int? smsToAbsent;
  ModelTestExamModel? exam;

  ModelTestContentModel copyWith({
    int? id,
    String? contentableType,
    int? contentableId,
    dynamic contentId,
    String? title,
    String? slug,
    dynamic description,
    dynamic createdBy,
    String? type,
    String? duration,
    dynamic photo,
    int? order,
    bool? canPreview,
    bool? paid,
    bool? active,
    DateTime? availableAt,
    bool? smsToAll,
    int? smsToPresent,
    int? smsToAbsent,
    ModelTestExamModel? exam,
  }) =>
      ModelTestContentModel(
        id: id ?? this.id,
        contentableType: contentableType ?? this.contentableType,
        contentableId: contentableId ?? this.contentableId,
        contentId: contentId ?? this.contentId,
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
        availableAt: availableAt ?? this.availableAt,
        smsToAll: smsToAll ?? this.smsToAll,
        smsToPresent: smsToPresent ?? this.smsToPresent,
        smsToAbsent: smsToAbsent ?? this.smsToAbsent,
        exam: exam ?? this.exam,
      );

  factory ModelTestContentModel.fromRawJson(String str) =>
      ModelTestContentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelTestContentModel.fromJson(Map<String, dynamic> json) =>
      ModelTestContentModel(
        id: json["id"],
        contentableType: json["contentable_type"],
        contentableId: json["contentable_id"],
        contentId: json["content_id"],
        title: json["title"] ?? '',
        slug: json["slug"],
        description: json["description"],
        createdBy: json["created_by"],
        type: json["type"],
        duration: json["duration"],
        photo: json["photo"],
        order: json["order"],
        canPreview: json["can_preview"],
        paid: json["paid"],
        active: json["active"],
        availableAt: json["available_at"] == null
            ? null
            : DateTime.parse(json["available_at"]),
        smsToAll: json["sms_to_all"],
        smsToPresent: json["sms_to_present"],
        smsToAbsent: json["sms_to_absent"],
        exam: json["exam"] == null
            ? null
            : ModelTestExamModel.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentable_type": contentableType,
        "contentable_id": contentableId,
        "content_id": contentId,
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
        "available_at":
            availableAt?.toIso8601String(),
        "sms_to_all": smsToAll,
        "sms_to_present": smsToPresent,
        "sms_to_absent": smsToAbsent,
        "exam": exam?.toJson(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

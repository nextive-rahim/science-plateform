import 'package:science_platform/src/feature/courses/sections/model/section_model.dart';
import 'package:science_platform/src/models/image_model.dart';
import 'package:science_platform/src/models/price_model.dart';

class CourseResponseModel {
  CourseModel? data;

  CourseResponseModel({
    this.data,
  });

  CourseResponseModel copyWith({
    CourseModel? data,
  }) =>
      CourseResponseModel(
        data: data ?? this.data,
      );

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) =>
      CourseResponseModel(
        data: json["data"] == null ? null : CourseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class CourseModel {
  int? id;
  String? title;
  String? slug;
  String? subtitle;
  SubscriptionStatusModel? subscriptionStatus;
  PriceModel? price;
  ImageModel? image;
  int? usersCount;
  CourseDetailsModel? courseDetails;
  List<InstructorModel>? instructors;
  List<SectionModel>? sections;
  List<Instalment>? instalments; //TODO: remove this

  CourseModel({
    this.id,
    this.title,
    this.slug,
    this.subtitle,
    this.subscriptionStatus,
    this.price,
    this.image,
    this.usersCount,
    this.courseDetails,
    this.instructors,
    this.sections,
    this.instalments,
  });

  bool get isFreeCourse => price?.amount == 0;

  String get getUserCount => (usersCount ?? 0).toString();

  bool get isSubscribed => subscriptionStatus?.status == "active";

  bool get isExpired => subscriptionStatus?.status == "expired";

  bool get hasDiscount => price?.discount != null;

  String get netPrice {
    return ((price?.amount ?? 0) - (price?.discount ?? 0)).toString();
  }

  CourseModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? subtitle,
    SubscriptionStatusModel? subscriptionStatus,
    PriceModel? price,
    ImageModel? image,
    int? usersCount,
    CourseDetailsModel? courseDetails,
    List<InstructorModel>? instructors,
    List<SectionModel>? sections,
  }) =>
      CourseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        subtitle: subtitle ?? this.subtitle,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        price: price ?? price,
        image: image ?? image,
        usersCount: usersCount ?? usersCount,
        courseDetails: courseDetails ?? courseDetails,
        instructors: instructors ?? instructors,
        sections: sections ?? sections,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        subtitle: json["subtitle"],
        subscriptionStatus: json["subscription_status"] == null
            ? null
            : SubscriptionStatusModel.fromJson(json["subscription_status"]),
        price:
            json["price"] == null ? null : PriceModel.fromJson(json["price"]),
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
        usersCount: json["users_count"],
        courseDetails: json["course_details"] == null
            ? null
            : CourseDetailsModel.fromJson(json["course_details"]),
        instructors: json["instructors"] == null
            ? []
            : List<InstructorModel>.from(
                json["instructors"].map((x) => InstructorModel.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<SectionModel>.from(
                json["sections"].map((x) => SectionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "subtitle": subtitle,
        "subscription_status": subscriptionStatus?.toJson(),
        "price": price?.toJson(),
        "image": image?.toJson(),
        "users_count": usersCount,
        "course_details": courseDetails?.toJson(),
        "instructors": instructors == null
            ? []
            : List<dynamic>.from(instructors!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.slug == slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ slug.hashCode;
  }
}

class CourseDetailsModel {
  int? id;
  int? courseId;
  dynamic video;
  String? description;
  List<String>? features;

  CourseDetailsModel({
    this.id,
    this.courseId,
    this.video,
    this.description,
    this.features,
  });

  CourseDetailsModel copyWith({
    int? id,
    int? courseId,
    dynamic video,
    String? description,
    List<String>? features,
  }) =>
      CourseDetailsModel(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        video: video ?? this.video,
        description: description ?? this.description,
        features: features ?? this.features,
      );

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailsModel(
        id: json["id"],
        courseId: json["course_id"],
        video: json["video"],
        description: json["description"],
        features: (json["features"] == null ||
                json["features"] == [] ||
                json["features"] == [null])
            ? []
            : List<String>.from(json["features"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "video": video,
        "description": description,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
      };
}

class InstructorModel {
  int? id;
  String? name;
  String? designation;
  String? institute;
  ImageModel? image;

  InstructorModel({
    this.id,
    this.name,
    this.designation,
    this.institute,
    this.image,
  });

  InstructorModel copyWith({
    int? id,
    String? name,
    String? designation,
    String? institute,
    ImageModel? image,
  }) =>
      InstructorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        designation: designation ?? this.designation,
        institute: institute ?? this.institute,
        image: image ?? this.image,
      );

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      InstructorModel(
        id: json["id"],
        name: json["name"],
        designation: json["designation"],
        institute: json["institute"],
        image:
            json["image"] == null ? null : ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "designation": designation,
        "institute": institute,
        "image": image?.toJson(),
      };
}

class SubscriptionStatusModel {
  String? status;
  DateTime? validTill;
  String? paymentType;

  SubscriptionStatusModel({
    this.status,
    this.validTill,
    this.paymentType,
  });

  SubscriptionStatusModel copyWith({
    String? status,
    DateTime? validTill,
    String? paymentType,
  }) =>
      SubscriptionStatusModel(
        status: status ?? this.status,
        validTill: validTill ?? this.validTill,
        paymentType: paymentType ?? this.paymentType,
      );

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionStatusModel(
        status: json["status"],
        validTill: json["valid_till"] == null
            ? null
            : DateTime.parse(json["valid_till"]),
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "valid_till": validTill?.toIso8601String(),
        "payment_type": paymentType,
      };
}

// TODO: delete later
class Instalment {
  Instalment({
    this.id,
    this.title,
    this.instalmentId,
    this.instalmentableId,
    this.instalmentableType,
    this.price,
    this.availableAt,
    this.expiresAt,
    this.durationType,
    this.duration,
    this.subscriptionValidTill,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.order,
    this.purchased,
    this.allowPurchase,
  });

  int? id;
  String? title;
  int? instalmentId;
  int? instalmentableId;
  String? instalmentableType;
  String? price;
  DateTime? availableAt;
  DateTime? expiresAt;
  String? durationType;
  int? duration;
  DateTime? subscriptionValidTill;
  dynamic active;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  dynamic order;
  bool? purchased;
  bool? allowPurchase;

  bool get isExpired =>
      expiresAt != null ? expiresAt!.isBefore(DateTime.now()) : false;

  Instalment copyWith({
    int? id,
    String? title,
    int? instalmentId,
    int? instalmentableId,
    String? instalmentableType,
    String? price,
    DateTime? availableAt,
    DateTime? expiresAt,
    String? durationType,
    int? duration,
    DateTime? subscriptionValidTill,
    dynamic active,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic discount,
    dynamic discountTill,
    dynamic discountedPrice,
    dynamic order,
    bool? purchased,
    bool? allowPurchase,
  }) =>
      Instalment(
        id: id ?? this.id,
        title: title ?? this.title,
        instalmentId: instalmentId ?? this.instalmentId,
        instalmentableId: instalmentableId ?? this.instalmentableId,
        instalmentableType: instalmentableType ?? this.instalmentableType,
        price: price ?? this.price,
        availableAt: availableAt ?? this.availableAt,
        expiresAt: expiresAt ?? this.expiresAt,
        durationType: durationType ?? this.durationType,
        duration: duration ?? this.duration,
        subscriptionValidTill:
            subscriptionValidTill ?? this.subscriptionValidTill,
        active: active ?? this.active,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        discount: discount ?? this.discount,
        discountTill: discountTill ?? this.discountTill,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        order: order ?? this.order,
        purchased: purchased ?? this.purchased,
        allowPurchase: allowPurchase ?? this.allowPurchase,
      );

  factory Instalment.fromJson(Map<String, dynamic> json) => Instalment(
        id: json["id"],
        title: json["title"],
        instalmentId: json["instalment_id"],
        instalmentableId: json["instalmentable_id"],
        instalmentableType: json["instalmentable_type"],
        price: json["price"],
        availableAt: json["available_at"] == null
            ? null
            : DateTime.parse(json["available_at"]),
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
        durationType: json["duration_type"],
        duration: json["duration"],
        subscriptionValidTill: json["subscription_valid_till"] == null
            ? null
            : DateTime.parse(json["subscription_valid_till"]),
        active: json["active"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        order: json["order"],
        purchased: json["purchased"],
        allowPurchase: json["allow_purchase"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "instalment_id": instalmentId,
        "instalmentable_id": instalmentableId,
        "instalmentable_type": instalmentableType,
        "price": price,
        "available_at":
            availableAt?.toIso8601String(),
        "expires_at": expiresAt?.toIso8601String(),
        "duration_type": durationType,
        "duration": duration,
        "subscription_valid_till": subscriptionValidTill?.toIso8601String(),
        "active": active,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "order": order,
        "purchased": purchased,
        "allow_purchase": allowPurchase,
      };
}

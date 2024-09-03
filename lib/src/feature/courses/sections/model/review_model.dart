import 'dart:convert';

ReviewsList reviewModelFromJson(String str) =>
    ReviewsList.fromJson(json.decode(str));

String reviewModelToJson(ReviewsList data) => json.encode(data.toJson());

class ReviewsList {
  ReviewsList({
    this.reviews,
  });

  List<ReviewModel>? reviews;

  ReviewsList copyWith({
    List<ReviewModel>? reviews,
  }) =>
      ReviewsList(
        reviews: reviews ?? this.reviews,
      );

  factory ReviewsList.fromJson(Map<String, dynamic> json) => ReviewsList(
        reviews: List<ReviewModel>.from(
            json["reviews"].map((x) => ReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reviews": reviews != null
            ? List<dynamic>.from(reviews!.map((x) => x.toJson()))
            : [],
      };
}

class ReviewModel {
  ReviewModel({
    this.id,
    this.rating,
    this.title,
    this.body,
    this.createdAt,
  });

  int? id;
  int? rating;
  dynamic title;
  String? body;
  DateTime? createdAt;

  ReviewModel copyWith({
    int? id,
    int? rating,
    dynamic title,
    String? body,
    DateTime? createdAt,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        title: title ?? this.title,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        rating: json["rating"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "title": title,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
      };
}

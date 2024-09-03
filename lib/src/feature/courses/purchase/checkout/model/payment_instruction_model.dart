class PaymentInstructionResponseModel {
  PaymentInstructionModel? data;

  PaymentInstructionResponseModel({
    this.data,
  });

  PaymentInstructionResponseModel copyWith({
    PaymentInstructionModel? data,
  }) =>
      PaymentInstructionResponseModel(
        data: data ?? this.data,
      );

  factory PaymentInstructionResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentInstructionResponseModel(
        data: json["data"] == null
            ? null
            : PaymentInstructionModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class PaymentInstructionModel {
  int? id;
  String? key;
  String? value;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentInstructionModel({
    this.id,
    this.key,
    this.value,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  PaymentInstructionModel copyWith({
    int? id,
    String? key,
    String? value,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PaymentInstructionModel(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
        slug: slug ?? this.slug,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PaymentInstructionModel.fromJson(Map<String, dynamic> json) =>
      PaymentInstructionModel(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        slug: json["slug"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

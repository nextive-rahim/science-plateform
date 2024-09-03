import 'dart:convert';

PaymentResponseModel paymentModelFromJson(String str) =>
    PaymentResponseModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentResponseModel data) =>
    json.encode(data.toJson());

class PaymentResponseModel {
  PaymentResponseModel({
    this.data,
  });

  PaymentDataModel? data;

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseModel(
        data: PaymentDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class PaymentDataModel {
  PaymentDataModel({
    this.id,
    this.userId,
    this.orderId,
    this.amount,
    this.transactionId,
    this.method,
    this.vendor,
    this.status,
    this.details,
    this.photo,
    this.paidAccount,
    this.paymentAccount,
    this.createdAt,
    this.order,
  });

  int? id;
  int? userId;
  int? orderId;
  String? amount;
  String? transactionId;
  String? method;
  String? vendor;
  String? status;
  dynamic details;
  dynamic photo;
  String? paidAccount;
  String? paymentAccount;
  DateTime? createdAt;
  Order? order;

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) =>
      PaymentDataModel(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        amount: json["amount"],
        transactionId: json["transaction_id"],
        method: json["method"],
        vendor: json["vendor"],
        status: json["status"],
        details: json["details"],
        photo: json["photo"],
        paidAccount: json["paid_account"],
        paymentAccount: json["payment_account"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "amount": amount,
        "transaction_id": transactionId,
        "method": method,
        "vendor": vendor,
        "status": status,
        "details": details,
        "photo": photo,
        "paid_account": paidAccount,
        "payment_account": paymentAccount,
        "created_at": createdAt!.toIso8601String(),
        "order": order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.total,
    this.discount,
    this.coupon,
    this.deliveryCharge,
    this.couponDiscount,
    this.grandTotal,
    this.paid,
    this.due,
    this.type,
    this.createdAt,
    this.status,
    this.sells,
  });

  int? id;
  int? userId;
  dynamic name;
  dynamic phone;
  dynamic address;
  String? total;
  String? discount;
  dynamic coupon;
  dynamic deliveryCharge;
  dynamic couponDiscount;
  String? grandTotal;
  String? paid;
  String? due;
  dynamic type;
  DateTime? createdAt;
  String? status;
  List<Sell>? sells;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        total: json["total"],
        discount: json["discount"],
        coupon: json["coupon"],
        deliveryCharge: json["delivery_charge"],
        couponDiscount: json["coupon_discount"],
        grandTotal: json["grand_total"],
        paid: json["paid"],
        due: json["due"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        sells: List<Sell>.from(json["sells"].map((x) => Sell.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address,
        "total": total,
        "discount": discount,
        "coupon": coupon,
        "delivery_charge": deliveryCharge,
        "coupon_discount": couponDiscount,
        "grand_total": grandTotal,
        "paid": paid,
        "due": due,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "status": status,
        "sells": List<dynamic>.from(sells!.map((x) => x.toJson())),
      };
}

class Sell {
  Sell({
    this.id,
    this.userId,
    this.orderId,
    this.rate,
    this.quantity,
    this.total,
    this.itemName,
    this.sellable,
    this.photo,
    this.type,
  });

  int? id;
  int? userId;
  int? orderId;
  String? rate;
  String? quantity;
  String? total;
  String? itemName;
  Sellable? sellable;
  String? photo;
  String? type;

  factory Sell.fromJson(Map<String, dynamic> json) => Sell(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        rate: json["rate"],
        quantity: json["quantity"],
        total: json["total"],
        itemName: json["item_name"],
        sellable: Sellable.fromJson(json["sellable"]),
        photo: json["photo"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "rate": rate,
        "quantity": quantity,
        "total": total,
        "item_name": itemName,
        "sellable": sellable?.toJson(),
        "photo": photo,
        "type": type,
      };
}

class Sellable {
  Sellable({
    this.id,
    this.createdBy,
    this.title,
    this.slug,
    this.photo,
    this.video,
    this.subtitle,
    this.description,
    this.difficulty,
    this.language,
    this.requirement,
    this.outcome,
    this.featured,
    this.price,
    this.duration,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.approved,
    this.active,
    this.commission,
    this.canPreview,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fakeUserCount,
    this.videoCount,
    this.audioCount,
    this.examCount,
    this.pdfCount,
    this.noteCount,
    this.linkCount,
    this.liveCount,
    this.zipCount,
    this.fileCount,
    this.writtenExamCount,
    this.requireGuardiansPhone,
    this.availableAt,
    this.admissionEndsAt,
    this.rating,
    this.subscriptionStatus,
  });

  int? id;
  int? createdBy;
  String? title;
  String? slug;
  String? photo;
  String? video;
  String? subtitle;
  String? description;
  String? difficulty;
  String? language;
  dynamic requirement;
  dynamic outcome;
  bool? featured;
  String? price;
  int? duration;
  String? discount;
  DateTime? discountTill;
  String? discountedPrice;
  bool? approved;
  dynamic active;
  dynamic commission;
  int? canPreview;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? fakeUserCount;
  int? videoCount;
  int? audioCount;
  int? examCount;
  int? pdfCount;
  int? noteCount;
  int? linkCount;
  int? liveCount;
  int? zipCount;
  int? fileCount;
  int? writtenExamCount;
  bool? requireGuardiansPhone;
  DateTime? availableAt;
  DateTime? admissionEndsAt;
  int? rating;
  dynamic subscriptionStatus;

  factory Sellable.fromJson(Map<String, dynamic> json) => Sellable(
        id: json["id"],
        createdBy: json["created_by"],
        title: json["title"],
        slug: json["slug"],
        photo: json["photo"],
        video: json["video"],
        subtitle: json["subtitle"],
        description: json["description"],
        difficulty: json["difficulty"],
        language: json["language"],
        requirement: json["requirement"],
        outcome: json["outcome"],
        featured: json["featured"] == '1' ? true : false,
        price: json["price"],
        duration: json["duration"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice: json["discounted_price"],
        approved: json["approved"],
        active: json["active"],
        commission: json["commission"],
        canPreview: json["can_preview"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fakeUserCount: json["fake_user_count"],
        videoCount: json["video_count"],
        audioCount: json["audio_count"],
        examCount: json["exam_count"],
        pdfCount: json["pdf_count"],
        noteCount: json["note_count"],
        linkCount: json["link_count"],
        liveCount: json["live_count"],
        zipCount: json["zip_count"],
        fileCount: json["file_count"],
        writtenExamCount: json["written_exam_count"],
        requireGuardiansPhone: json["require_guardians_phone"],
        availableAt: json["available_at"] == null
            ? null
            : DateTime.parse(json["available_at"]),
        admissionEndsAt: json["admission_ends_at"] == null
            ? null
            : DateTime.parse(json["admission_ends_at"]),
        rating: json["rating"],
        subscriptionStatus: json["subscription_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "slug": slug,
        "photo": photo,
        "video": video,
        "subtitle": subtitle,
        "description": description,
        "difficulty": difficulty,
        "language": language,
        "requirement": requirement,
        "outcome": outcome,
        "featured": featured,
        "price": price,
        "duration": duration,
        "discount": discount,
        "discount_till": discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "approved": approved,
        "active": active,
        "commission": commission,
        "can_preview": canPreview,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "fake_user_count": fakeUserCount,
        "video_count": videoCount,
        "audio_count": audioCount,
        "exam_count": examCount,
        "pdf_count": pdfCount,
        "note_count": noteCount,
        "link_count": linkCount,
        "live_count": liveCount,
        "zip_count": zipCount,
        "file_count": fileCount,
        "written_exam_count": writtenExamCount,
        "require_guardians_phone": requireGuardiansPhone,
        "available_at": availableAt!.toIso8601String(),
        "admission_ends_at": admissionEndsAt!.toIso8601String(),
        "rating": rating,
        "subscription_status": subscriptionStatus,
      };
}

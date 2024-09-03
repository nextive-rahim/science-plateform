class CartModel {
  int? priceId;
  String? coupon;

  CartModel({
    this.priceId,
    this.coupon,
  });

  CartModel copyWith({
    int? priceId,
    String? coupon,
  }) =>
      CartModel(
        priceId: priceId ?? this.priceId,
        coupon: coupon ?? this.coupon,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        priceId: json["price_id"],
        coupon: json["coupon"],
      );

  Map<String, dynamic> toJson() => {
        "price_id": priceId,
        "coupon": coupon,
      };
}

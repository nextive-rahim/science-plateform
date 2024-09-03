part of '../view/checkout_page.dart';

class _OrderSummery extends StatelessWidget {
  const _OrderSummery({
    required this.controller,
  });

  final CheckoutViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckoutInfoTypeItem(
          itemTitle: TextConstants.total,
          itemValue: "৳ ${controller.totalAmount}",
        ),
        CheckoutInfoTypeItem(
          itemTitle: TextConstants.discount,
          itemValue: "৳ ${controller.discountAmount}",
        ),
        CheckoutInfoTypeItem(
          itemTitle: TextConstants.coupon,
          itemValue: "৳ ${controller.couponAmount}",
        ),
        CheckoutInfoTypeItem(
          itemTitle: TextConstants.haveToPay,
          itemValue: "৳ ${controller.payableAmount}",
        ),
      ],
    );
  }
}

part of '../view/checkout_page.dart';

class _OrderDetails extends StatelessWidget {
  const _OrderDetails({
    required this.orderData,
  });
  final OrderDataModel orderData;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          const CheckoutInfoTypeItem(
            itemTitle: TextConstants.orderPlaced,
            itemValue: "",
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary5,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightBlack10.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              children: [
                CheckoutInfoTypeItem(
                  itemTitle: TextConstants.orderId,
                  itemValue: '${orderData.id}',
                  isSmallerValue: true,
                ),
                CheckoutInfoTypeItem(
                  itemTitle: TextConstants.orderDate,
                  itemValue: '${getFormattedDateTime(orderData.createdAt)}',
                  isSmallerValue: true,
                ),
                CheckoutInfoTypeItem(
                  itemTitle: TextConstants.total,
                  itemValue: "৳ ${orderData.total}",
                  isSmallerValue: true,
                ),
                CheckoutInfoTypeItem(
                  itemTitle: TextConstants.status,
                  itemValue: "${orderData.status}".toUpperCase(),
                  isSmallerValue: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

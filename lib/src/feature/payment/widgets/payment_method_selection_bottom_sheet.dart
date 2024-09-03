import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';

/// Use [PaymentMethodCard] in buttons array, to add more payment methods easily
Future<void> paymentMethodSelectionBottomSheet({
  required BuildContext context,
  List<Widget>? buttons,
  bool isLoading = false,
}) async {
  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: isLoading ? () {} : null,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 27 / 18,
                ),
              ),
              const SizedBox(height: 16),
              ...buttons ?? [],
            ],
          ),
        ),
      );
    },
  );
}

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({
    super.key,
    required this.logo,
    this.onTap,
    this.isLoading = false,
  });
  final String logo;
  final Function()? onTap;
  final bool isLoading;

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.lightBlack10,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightBlack10,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: widget.onTap,
                  child: Image.asset(
                    widget.logo,
                    fit: BoxFit.contain,
                  ),
                ),
        ],
      ),
    );
  }
}

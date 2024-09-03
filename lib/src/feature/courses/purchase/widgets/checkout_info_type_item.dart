import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:science_platform/src/widgets/pill_title.dart';

class CheckoutInfoTypeItem extends StatelessWidget {
  const CheckoutInfoTypeItem({
    super.key,
    required this.itemTitle,
    required this.itemValue,
    this.bottomPadding,
    this.valueTextStyle,
    this.isSmallerValue = false,
  });

  final String itemTitle;
  final String itemValue;
  final double? bottomPadding;
  final bool isSmallerValue;
  final TextStyle? valueTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: bottomPadding ?? 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: PillTitle(title: itemTitle)),
          Text(
            itemValue,
            style: valueTextStyle ??
                (isSmallerValue
                    ? AppTextStyle.bold16.copyWith(
                        color: AppColors.primary,
                      )
                    : AppTextStyle.bold20.copyWith(
                        color: AppColors.primary,
                      )),
          ),
        ],
      ),
    );
  }
}

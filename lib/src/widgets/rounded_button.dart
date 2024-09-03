import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.title,
    this.onPressed,
    this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.backgroundColor,
    this.radius,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.showShadow = false,
  });

  final String? title;
  final Function()? onPressed;
  final Widget? child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final bool? showShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 5,
          horizontal: horizontalPadding ?? 12,
        ),
        decoration: BoxDecoration(
          boxShadow: (showShadow == true)
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
          color: backgroundColor,
          gradient: backgroundColor == null
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : null,
          borderRadius: BorderRadius.circular(radius ?? 50),
          border: borderColor == null
              ? null
              : Border.all(
                  color: borderColor ?? AppColors.primary,
                ),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: child ??
              Text(
                title ?? '',
                style: AppTextStyle.bold14.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 12,
                  height: 16 / 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
        ),
      ),
    );
  }
}

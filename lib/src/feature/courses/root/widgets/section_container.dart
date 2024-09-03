// ignore_for_file: unused_element

part of '../view/course_details_page.dart';

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.radius,
    this.onTap,
    this.color,
    this.bottomMargin,
  });

  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? bottomMargin;
  final double? radius;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(
          color: AppColors.lightBlack10,
        ),
      ),
      margin: EdgeInsets.only(bottom: bottomMargin ?? 15),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 10,
        vertical: verticalPadding ?? 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 10),
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}

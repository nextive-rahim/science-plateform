import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientTitle extends StatelessWidget {
  const GradientTitle({
    super.key,
    required this.title,
    this.fontSize,
  });

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      title,
      style: TextStyle(fontSize: fontSize),
      gradientType: GradientType.radial,
      colors: const [
        Color(0xFF426058),
        Color(0xFF00A579),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class KShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final BoxShape shape;

  const KShimmerContainer({
    super.key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 0,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 1),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
        ),
      ),
    );
  }
}

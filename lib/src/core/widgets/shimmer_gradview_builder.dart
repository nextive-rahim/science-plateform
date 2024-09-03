import 'package:science_platform/src/core/widgets/k_shimmer_container.dart';
import 'package:flutter/material.dart';

class ShimmerGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double borderRadius;

  const ShimmerGridViewBuilder({
    super.key,
    this.itemCount = 10,
    this.childAspectRatio = 4 / 7,
    this.borderRadius = 8,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        // left: 15,
        // right: 15,
        // top: 15,
        bottom: 80,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      shrinkWrap: true,
      itemBuilder: (context, index) => KShimmerContainer(
        borderRadius: borderRadius,
      ),
    );
  }
}

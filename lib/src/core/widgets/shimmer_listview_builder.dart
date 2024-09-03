import 'package:science_platform/src/core/widgets/k_shimmer_container.dart';
import 'package:flutter/material.dart';

class ShimmerListViewBuilder extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double borderRadius;

  const ShimmerListViewBuilder({
    super.key,
    this.itemCount = 10,
    this.itemHeight = 120,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 20,
      ),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: itemCount,
      shrinkWrap: true,
      itemBuilder: (context, index) => KShimmerContainer(
        borderRadius: borderRadius,
        height: itemHeight,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}

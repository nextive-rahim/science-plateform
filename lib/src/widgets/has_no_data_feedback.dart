import 'package:flutter/material.dart';
import 'package:science_platform/src/utils/assets.dart';

class HasNoDataFeedback extends StatelessWidget {
  const HasNoDataFeedback({
    super.key,
    this.onRefresh,
    this.imageHeight,
    this.imageWidth,
    this.canRefresh = true,
  });

  final Future<void> Function()? onRefresh;
  final double? imageHeight;
  final double? imageWidth;
  final bool? canRefresh;

  @override
  Widget build(BuildContext context) {
    return canRefresh == true
        ? RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            child: _buildChild(),
          )
        : _buildImage();
  }

  Widget _buildImage() {
    return SizedBox(
      width: imageWidth ?? 120,
      child: Center(
        child: Image.asset(
          Assets.logo,
          height: imageHeight ?? 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Stack _buildChild() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: imageWidth ?? 120,
          child: Center(
            child: Image.asset(
              Assets.logo,
              height: imageHeight ?? 120,
              fit: BoxFit.contain,
            ),
          ),
        ),
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
        )
      ],
    );
  }
}

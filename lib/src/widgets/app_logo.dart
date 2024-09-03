import 'package:science_platform/src/utils/assets.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80, bottom: 50),
      height: 85,
      width: 179,
      child: Center(
        child: Image.asset(
          Assets.logo,
          fit: BoxFit.contain,
          scale: 1,
        ),
      ),
    );
  }
}

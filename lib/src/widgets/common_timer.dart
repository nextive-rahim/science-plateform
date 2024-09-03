import 'dart:async';

import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class CommonTimer extends StatefulWidget {
  const CommonTimer({
    super.key,
    required this.timerDuration,
    this.textStyle,
    this.showHour = false,
    this.startTimer,
    this.onFinish,
  });

  final Duration timerDuration;
  final TextStyle? textStyle;
  final bool? showHour;
  final bool? startTimer;
  final Function()? onFinish;

  @override
  State<CommonTimer> createState() => _CommonTimerState();
}

class _CommonTimerState extends State<CommonTimer> {
  Timer? countdownTimer;
  late Duration myDuration;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    myDuration = widget.timerDuration;
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (widget.startTimer == true) {
          _setCountDown();
        }
      },
    );
  }

  void _stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void _setCountDown() {
    setState(() {
      final seconds = myDuration.inSeconds - 1;
      if (seconds < 0) {
        widget.onFinish?.call();
        _stopTimer();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return widget.showHour == true
        ? Text(
            '$hours:$minutes:$seconds',
            style: widget.textStyle ??
                AppTextStyle.bold20.copyWith(
                  color: AppColors.primary,
                ),
          )
        : Text(
            '$minutes:$seconds',
            style: widget.textStyle ??
                AppTextStyle.bold20.copyWith(
                  color: AppColors.primary,
                ),
          );
  }
}

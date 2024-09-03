import 'package:flutter/material.dart';

class ScrollableWrapper extends StatelessWidget {
  final Widget child;
  final bool? dismissKeyboard;

  const ScrollableWrapper({
    super.key,
    required this.child,
    this.dismissKeyboard = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: dismissKeyboard == true
                ? ScrollViewKeyboardDismissBehavior.onDrag
                : ScrollViewKeyboardDismissBehavior.manual,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

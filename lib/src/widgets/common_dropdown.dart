import 'package:flutter/material.dart';
import 'package:science_platform/src/core/theme/colors.dart';

class CommonPopupMenu extends StatelessWidget {
  const CommonPopupMenu({
    super.key,
    required this.onChanged,
    required this.dropdownItems,
    required this.value,
  });
  final void Function(String)? onChanged;
  final List<String> dropdownItems;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: onChanged,
      itemBuilder: (context) {
        return [
          for (var value in dropdownItems)
            PopupMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
        ];
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightBlack40,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value!,
                style: const TextStyle(color: AppColors.lightBlack60),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

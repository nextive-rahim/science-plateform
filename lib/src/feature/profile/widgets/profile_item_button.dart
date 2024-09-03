import 'package:flutter/material.dart';

class ProfileItemButton extends StatelessWidget {
  const ProfileItemButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final String icon;
  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4FA),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                icon,
                height: 22,
                width: 22,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 21 / 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

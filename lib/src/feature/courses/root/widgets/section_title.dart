part of '../view/course_details_page.dart';

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.bold20.copyWith(
              height: 32 / 20,
            ),
          ),
        ),
      ],
    );
  }
}

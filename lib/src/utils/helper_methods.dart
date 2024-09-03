import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher(String link) async {
  final Uri uriLink = Uri.parse(link);
  if (await canLaunchUrl(uriLink)) {
    await launchUrl(
      uriLink,
      mode: LaunchMode.externalApplication,
    );
  }
}

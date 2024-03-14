import 'package:url_launcher/url_launcher_string.dart';

class LauncherService {

Future<void> openGoogleMaps(double latitude, double longitude) async {
  final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
    
  }
} 
}
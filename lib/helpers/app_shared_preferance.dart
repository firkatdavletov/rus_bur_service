import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  initPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('recipients', 'firkat.davletov@ya.ru');
    prefs.setString('subject', 'Subject');
    prefs.setString('text', 'Text');
    prefs.setDouble('maxPictureHeight', 300.0);
    prefs.setDouble('maxPictureWidth', 300.0);
    prefs.setInt('pictureQuality', 80);
  }
}
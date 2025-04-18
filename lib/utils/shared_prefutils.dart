
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{
  static SharedPreferences? prefs;

    Future<void> initSharedPref() async {
      prefs = await SharedPreferences.getInstance();
  }
}
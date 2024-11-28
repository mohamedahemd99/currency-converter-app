import 'package:shared_preferences/shared_preferences.dart';

import '../application/constants/cache_keys.dart';

class PrefManager {
  static SharedPreferences? prefs;

  static Future<void> setupSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clearSharedPreferences() async {
    await prefs?.clear();
  }

  static void setCurrencyList(String currencyList) {
    prefs?.setString(PrefManagerConstants.currencyListKey, currencyList);
  }

  static String? getCurrencyList() {
    return prefs?.getString(PrefManagerConstants.currencyListKey);
  }
}

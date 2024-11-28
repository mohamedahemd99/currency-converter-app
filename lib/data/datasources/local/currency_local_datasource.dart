import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../core/preference/pref_manager.dart';

@lazySingleton
class CurrencyLocalDataSource {
  Future<void> cacheCurrencies(Map<String, dynamic> currencies) async {
    try {
      final encodedData = jsonEncode(currencies);
      PrefManager.setCurrencyList(encodedData);
    } catch (e) {
      print("Failed to cache currencies: $e");
    }
  }

  Future<Map<String, dynamic>?> getCachedCurrencies() async {
    try {
      final cachedData = PrefManager.getCurrencyList();
      if (cachedData == null) {
        // Return null if no data exists
        return null;
      }
      // Decode and return the cached data
      return jsonDecode(cachedData) as Map<String, dynamic>;
    } catch (e) {
      // Log or handle decoding error
      print("Failed to retrieve cached currencies: $e");
      return null; // Return null if decoding fails
    }
  }
}

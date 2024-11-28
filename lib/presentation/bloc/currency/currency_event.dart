import 'package:flutter/material.dart';

@immutable
sealed class CurrencyEvent {}

class FetchCurrencies extends CurrencyEvent {}

class ConvertCurrency extends CurrencyEvent {
  final String baseCurrency;
  final String targetCurrency;

  ConvertCurrency({required this.baseCurrency, required this.targetCurrency});
}

class FetchHistoricalCurrency extends CurrencyEvent {
  final String baseCurrency;
  final String targetCurrency;
  final String date;

  FetchHistoricalCurrency({
    required this.baseCurrency,
    required this.targetCurrency,
    required this.date,
  });
}

import 'package:currency_converter_app/core/error/error_message_model.dart';
import 'package:currency_converter_app/core/error/exception.dart';
import 'package:currency_converter_app/data/datasources/local/currency_local_datasource.dart';
import 'package:currency_converter_app/data/datasources/remote/currency_api_service.dart';
import 'package:currency_converter_app/data/models/currency_converter.dart';
import 'package:currency_converter_app/data/models/currency_history.dart';
import 'package:currency_converter_app/data/models/currency_response_model.dart';
import 'package:currency_converter_app/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter_app/domain/entities/currency_entity.dart';
import 'package:currency_converter_app/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:mocktail/mocktail.dart";

class MockCurrencyApiService extends Mock implements CurrencyApiService {}

class MockCurrencyLocalDataSource extends Mock
    implements CurrencyLocalDataSource {}

void main() {
  late MockCurrencyApiService apiService;
  late MockCurrencyLocalDataSource localService;
  late CurrencyRepository repository;

  setUp(() {
    apiService = MockCurrencyApiService();
    localService = MockCurrencyLocalDataSource();
    repository = CurrencyRepositoryImpl(apiService, localService);
  });

  group("convertCurrency", () {
    const baseCurrency = "USD";
    const currenciesChangesTo = "EUR";
    final converterEntity =
        CurrencyConverter(data: {baseCurrency: 1.0490206184});

    test("returns converted currency when API call is successful", () async {
      when(() => apiService.convertCurrency(
            baseCurrency: baseCurrency,
            currenciesChangesTo: currenciesChangesTo,
          )).thenAnswer((_) async => converterEntity);

      final result =
          await repository.convertCurrency(baseCurrency, currenciesChangesTo);

      verify(() => apiService.convertCurrency(
          baseCurrency: baseCurrency,
          currenciesChangesTo: currenciesChangesTo));
      expect(result, Right(converterEntity));
    });
  });

  group("getCurrencies", () {
    final currencyResponse = CurrencyResponseModel(data: [
      Datum(
        code: "EUR",
        decimalDigits: 2,
        name: "Euro",
        namePlural: "Euros",
        rounding: 0,
        symbol: "€",
        symbolNative: "€",
        type: "fiat",
      )
    ]);

    test("fetches from API and caches currencies when not available locally",
        () async {
      when(() => localService.getCachedCurrencies())
          .thenAnswer((_) async => null);

      when(() => apiService.getCurrencies())
          .thenAnswer((_) async => currencyResponse);

      when(() => localService.cacheCurrencies(any()))
          .thenAnswer((_) async => {});

      final result = await repository.getCurrencies();

      verify(() => localService.getCachedCurrencies()).called(1);
      verify(() => apiService.getCurrencies()).called(1);
      verify(() => localService.cacheCurrencies(currencyResponse.toJson()))
          .called(1);
      expect(result, Right(currencyResponse)); // Expect the correct model
    });

    test("returns ServerException if API call fails", () async {
      // Simulate no cached data
      when(() => localService.getCachedCurrencies())
          .thenAnswer((_) async => null);

      // Simulate API failure
      when(() => apiService.getCurrencies()).thenThrow(ServerException(
          errorMessageModel: ErrorMessageModel(message: "API Error")));

      final result = await repository.getCurrencies();

      verify(() => localService.getCachedCurrencies()).called(1);
      verify(() => apiService.getCurrencies()).called(1);
      expect(result, isA<Left<ServerException, CurrencyEntity>>());
      expect(result.fold((l) => l.errorMessageModel.message, (r) => null),
          "API Error"); // Check the error message
    });
  });
  group("historicalCurrency", () {
    const baseCurrency = "USD";
    const targetCurrency = "EUR";
    const date = "2024-01-01";
    final historyEntity = CurrencyHistory(data: {
      "2024-11-20": {"USD": 1.0547520776}
    });

    test("returns historical data when API call is successful", () async {
      when(() => apiService.historicalCurrency(
            baseCurrency: baseCurrency,
            currenciesChangesTo: targetCurrency,
            date: date,
          )).thenAnswer((_) async => historyEntity);

      final result = await repository.historicalCurrency(
          baseCurrency, targetCurrency, date);

      verify(() => apiService.historicalCurrency(
          baseCurrency: baseCurrency,
          currenciesChangesTo: targetCurrency,
          date: date));
      expect(result, Right(historyEntity));
    });
  });
}

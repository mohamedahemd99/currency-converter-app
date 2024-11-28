import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_app/core/error/error_message_model.dart';
import 'package:currency_converter_app/core/error/exception.dart';
import 'package:currency_converter_app/domain/entities/currency_converter_entity.dart';
import 'package:currency_converter_app/domain/entities/currency_entity.dart';
import 'package:currency_converter_app/domain/entities/currency_history_entity.dart';
import 'package:currency_converter_app/domain/usecases/fetch_converted_currency_usecase.dart';
import 'package:currency_converter_app/domain/usecases/fetch_currency_list_usecase.dart';
import 'package:currency_converter_app/domain/usecases/fetch_historical_currency_usecase.dart';
import 'package:currency_converter_app/presentation/bloc/currency/currency_event.dart';
import 'package:currency_converter_app/presentation/bloc/currency/currency_states.dart';
import 'package:currency_converter_app/presentation/bloc/currency_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}

class MockFetchConvertedCurrencyUseCase extends Mock
    implements FetchConvertedCurrencyUseCase {}

class MockFetchHistoricalCurrencyUseCase extends Mock
    implements FetchHistoricalCurrencyUseCase {}

void main() {
  late MockGetCurrenciesUseCase mockGetCurrenciesUseCase;
  late MockFetchConvertedCurrencyUseCase mockFetchConvertedCurrencyUseCase;
  late MockFetchHistoricalCurrencyUseCase mockFetchHistoricalCurrencyUseCase;
  late CurrencyBloc currencyBloc;

  setUp(() {
    mockGetCurrenciesUseCase = MockGetCurrenciesUseCase();
    mockFetchConvertedCurrencyUseCase = MockFetchConvertedCurrencyUseCase();
    mockFetchHistoricalCurrencyUseCase = MockFetchHistoricalCurrencyUseCase();

    currencyBloc = CurrencyBloc(
      mockGetCurrenciesUseCase,
      mockFetchConvertedCurrencyUseCase,
      mockFetchHistoricalCurrencyUseCase,
    );
  });

  tearDown(() {
    currencyBloc.close();
  });
  const tCurrencyHistoryEntity = CurrencyHistoryEntity(data: {
    "2024-11-20": {"USD": 1.0547520776}
  });
  final exception = ServerException(
      errorMessageModel: ErrorMessageModel(message: 'Server Error'));
  final tCurrencyConverterEntity =
      CurrencyConverterEntity(data: {"USD": 1.0490206184});
  final CurrencyEntity testCurrencies = CurrencyEntity(data: [
    CurrencyDetail(
      code: "USD",
      name: "United States Dollar",
      symbol: "\$",
    ),
    CurrencyDetail(
      code: "EUR",
      name: "Euro",
      symbol: "€",
    ),
  ]);
  group('FetchCurrencies', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyLoading, CurrencyLoaded] when FetchCurrencies is successful',
      build: () {
        when(() => mockGetCurrenciesUseCase())
            .thenAnswer((_) async => Right(testCurrencies));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(FetchCurrencies()),
      expect: () => [
        CurrencyLoading(),
        CurrencyLoaded(currencyData: testCurrencies.data!),
      ],
      verify: (_) {
        verify(() => mockGetCurrenciesUseCase()).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyLoading, CurrencyError] when FetchCurrencies fails',
      build: () {
        when(() => mockGetCurrenciesUseCase())
            .thenAnswer((_) async => Left(exception));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(FetchCurrencies()),
      expect: () => [
        CurrencyLoading(),
        isA<CurrencyError>(),
      ],
      verify: (_) {
        verify(() => mockGetCurrenciesUseCase()).called(1);
      },
    );
  });

  group('ConvertCurrency', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyConversionLoading, CurrencyConversionLoaded] when ConvertCurrency is successful',
      build: () {
        when(() => mockFetchConvertedCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
            )).thenAnswer((_) async => Right(tCurrencyConverterEntity));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(ConvertCurrency(
        baseCurrency: "USD",
        targetCurrency: "EUR",
      )),
      expect: () => [
        CurrencyConversionLoading(),
        CurrencyConversionLoaded(currencyConversion: tCurrencyConverterEntity),
      ],
      verify: (_) {
        verify(() => mockFetchConvertedCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
            )).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyConversionLoading, CurrencyError] when ConvertCurrency fails',
      build: () {
        when(() => mockFetchConvertedCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
            )).thenAnswer((_) async => Left(exception));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(ConvertCurrency(
        baseCurrency: "USD",
        targetCurrency: "EUR",
      )),
      expect: () => [
        CurrencyConversionLoading(),
        isA<CurrencyError>(),
      ],
      verify: (_) {
        verify(() => mockFetchConvertedCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
            )).called(1);
      },
    );
  });

  group('FetchHistoricalCurrency', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyHistoricalLoading, CurrencyHistoricalLoaded] when FetchHistoricalCurrency is successful',
      build: () {
        when(() => mockFetchHistoricalCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
              date: "2024-01-01",
            )).thenAnswer((_) async => Right(tCurrencyHistoryEntity));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(FetchHistoricalCurrency(
        baseCurrency: "USD",
        targetCurrency: "EUR",
        date: "2024-01-01",
      )),
      expect: () => [
        CurrencyHistoricalLoading(),
        CurrencyHistoricalLoaded(currencyHistory: tCurrencyHistoryEntity),
      ],
      verify: (_) {
        verify(() => mockFetchHistoricalCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
              date: "2024-01-01",
            )).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyHistoricalLoading, CurrencyError] when FetchHistoricalCurrency fails',
      build: () {
        when(() => mockFetchHistoricalCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
              date: "2024-01-01",
            )).thenAnswer((_) async => Left(exception));
        return currencyBloc;
      },
      act: (bloc) => bloc.add(FetchHistoricalCurrency(
        baseCurrency: "USD",
        targetCurrency: "EUR",
        date: "2024-01-01",
      )),
      expect: () => [
        CurrencyHistoricalLoading(),
        isA<CurrencyError>(),
      ],
      verify: (_) {
        verify(() => mockFetchHistoricalCurrencyUseCase(
              baseCurrency: "USD",
              currenciesChangesTo: "EUR",
              date: "2024-01-01",
            )).called(1);
      },
    );
  });
}

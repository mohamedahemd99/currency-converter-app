import 'package:currency_converter_app/core/error/error_message_model.dart';
import 'package:currency_converter_app/core/error/exception.dart';
import 'package:currency_converter_app/domain/entities/currency_history_entity.dart';
import 'package:currency_converter_app/domain/repositories/currency_repository.dart';
import 'package:currency_converter_app/domain/usecases/fetch_historical_currency_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class
class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late MockCurrencyRepository mockCurrencyRepository;
  late FetchHistoricalCurrencyUseCase useCase;

  setUp(() {
    mockCurrencyRepository = MockCurrencyRepository();
    useCase = FetchHistoricalCurrencyUseCase(mockCurrencyRepository);
  });

  const baseCurrency = 'USD';
  const currenciesChangesTo = 'EUR';
  const date = '2024-11-01';

  const tCurrencyHistoryEntity = CurrencyHistoryEntity(data: {
    "2024-11-20": {"USD": 1.0547520776}
  });

  test('should return historical currency data when the call is successful',
      () async {
    when(() => mockCurrencyRepository.historicalCurrency(
          baseCurrency,
          currenciesChangesTo,
          date,
        )).thenAnswer((_) async => const Right(tCurrencyHistoryEntity));

    final result = await useCase(
        baseCurrency: baseCurrency,
        currenciesChangesTo: currenciesChangesTo,
        date: date);

    expect(result, const Right(tCurrencyHistoryEntity));
    verify(() => mockCurrencyRepository.historicalCurrency(
          baseCurrency,
          currenciesChangesTo,
          date,
        )).called(1);
  });

  test('should return ServerException when the call fails', () async {
    final exception = ServerException(
        errorMessageModel: ErrorMessageModel(message: 'Server Error'));
    when(() => mockCurrencyRepository.historicalCurrency(
          baseCurrency,
          currenciesChangesTo,
          date,
        )).thenAnswer((_) async => Left(exception));

    final result = await useCase(
        baseCurrency: baseCurrency,
        currenciesChangesTo: currenciesChangesTo,
        date: date);

    expect(result, Left(exception));
    verify(() => mockCurrencyRepository.historicalCurrency(
          baseCurrency,
          currenciesChangesTo,
          date,
        )).called(1);
  });
}

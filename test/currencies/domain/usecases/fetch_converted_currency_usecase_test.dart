import 'package:currency_converter_app/core/error/error_message_model.dart';
import 'package:currency_converter_app/core/error/exception.dart';
import 'package:currency_converter_app/domain/entities/currency_converter_entity.dart';
import 'package:currency_converter_app/domain/repositories/currency_repository.dart';
import 'package:currency_converter_app/domain/usecases/fetch_converted_currency_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class
class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late MockCurrencyRepository mockCurrencyRepository;
  late FetchConvertedCurrencyUseCase useCase;

  setUp(() {
    mockCurrencyRepository = MockCurrencyRepository();
    useCase = FetchConvertedCurrencyUseCase(mockCurrencyRepository);
  });

  const baseCurrency = 'USD';
  const currenciesChangesTo = 'EUR';

  const currencyData = {
    'EUR': 0.85,
  };

  const tCurrencyConverterEntity = CurrencyConverterEntity(data: currencyData);

  test('should return converted currency data when the call is successful',
      () async {
    when(() => mockCurrencyRepository.convertCurrency(
          baseCurrency,
          currenciesChangesTo,
        )).thenAnswer((_) async => Right(tCurrencyConverterEntity));

    final result = await useCase(
        baseCurrency: baseCurrency, currenciesChangesTo: currenciesChangesTo);

    expect(result, Right(tCurrencyConverterEntity));
    verify(() => mockCurrencyRepository.convertCurrency(
          baseCurrency,
          currenciesChangesTo,
        )).called(1);
  });

  test('should return ServerException when the call fails', () async {
    final exception = ServerException(
        errorMessageModel: ErrorMessageModel(message: 'Server Error'));
    when(() => mockCurrencyRepository.convertCurrency(
          baseCurrency,
          currenciesChangesTo,
        )).thenAnswer((_) async => Left(exception));

    final result = await useCase(
        baseCurrency: baseCurrency, currenciesChangesTo: currenciesChangesTo);

    expect(result, Left(exception));
    verify(() => mockCurrencyRepository.convertCurrency(
          baseCurrency,
          currenciesChangesTo,
        )).called(1);
  });
}

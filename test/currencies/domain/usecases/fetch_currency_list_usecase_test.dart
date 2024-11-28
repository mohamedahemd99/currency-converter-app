import 'package:currency_converter_app/core/error/error_message_model.dart';
import 'package:currency_converter_app/core/error/exception.dart';
import 'package:currency_converter_app/domain/entities/currency_entity.dart';
import 'package:currency_converter_app/domain/repositories/currency_repository.dart';
import 'package:currency_converter_app/domain/usecases/fetch_currency_list_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late GetCurrenciesUseCase useCase;
  late MockCurrencyRepository mockCurrencyRepository;

  setUp(() {
    mockCurrencyRepository = MockCurrencyRepository();
    useCase = GetCurrenciesUseCase(mockCurrencyRepository);
  });

  group('GetCurrenciesUseCase', () {
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

    test('should return list of currencies when repository call is successful',
        () async {
      when(() => mockCurrencyRepository.getCurrencies())
          .thenAnswer((_) async => Right(testCurrencies));

      final result = await useCase();

      verify(() => mockCurrencyRepository.getCurrencies()).called(1);
      expect(result, equals(Right(testCurrencies)));
    });

    test('should return ServerException when repository call fails', () async {
      final exception = ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred."));
      when(() => mockCurrencyRepository.getCurrencies())
          .thenAnswer((_) async => Left(exception));

      final result = await useCase();

      verify(() => mockCurrencyRepository.getCurrencies()).called(1);
      expect(result, equals(Left(exception)));
    });
  });
}

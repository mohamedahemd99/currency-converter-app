import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exception.dart';
import '../entities/currency_converter_entity.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class FetchConvertedCurrencyUseCase {
  final CurrencyRepository currencyRepository;

  FetchConvertedCurrencyUseCase(this.currencyRepository);

  Future<Either<ServerException, CurrencyConverterEntity>> call(
      {required String baseCurrency,
      required String currenciesChangesTo}) async {
    return currencyRepository.convertCurrency(
        baseCurrency, currenciesChangesTo);
  }
}

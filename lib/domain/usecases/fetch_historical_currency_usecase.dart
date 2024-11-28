import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exception.dart';
import '../entities/currency_history_entity.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class FetchHistoricalCurrencyUseCase {
  final CurrencyRepository currencyRepository;

  FetchHistoricalCurrencyUseCase(this.currencyRepository);

  Future<Either<ServerException, CurrencyHistoryEntity>> call(
      {required String baseCurrency,
      required String currenciesChangesTo,
      required String date}) async {
    return currencyRepository.historicalCurrency(
        baseCurrency, currenciesChangesTo, date);
  }
}

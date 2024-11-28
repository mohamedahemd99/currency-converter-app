import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../entities/currency_converter_entity.dart';
import '../entities/currency_entity.dart';
import '../entities/currency_history_entity.dart';

abstract class CurrencyRepository {
  Future<Either<ServerException, CurrencyEntity>> getCurrencies();
  Future<Either<ServerException, CurrencyConverterEntity>> convertCurrency(
    String baseCurrency,
    String currenciesChangesTo,
  );
  Future<Either<ServerException, CurrencyHistoryEntity>> historicalCurrency(
      String baseCurrency, String currenciesChangesTo, String date);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exception.dart';
import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class GetCurrenciesUseCase {
  final CurrencyRepository currencyRepository;

  GetCurrenciesUseCase(this.currencyRepository);

  Future<Either<ServerException, CurrencyEntity>> call() async {
    return currencyRepository.getCurrencies();
  }
}

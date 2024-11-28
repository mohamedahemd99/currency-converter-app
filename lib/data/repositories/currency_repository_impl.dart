import 'package:currency_converter_app/domain/entities/currency_converter_entity.dart';
import 'package:currency_converter_app/domain/entities/currency_entity.dart';
import 'package:currency_converter_app/domain/entities/currency_history_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/error_message_model.dart';
import '../../core/error/exception.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/local/currency_local_datasource.dart';
import '../datasources/remote/currency_api_service.dart';
import '../models/currency_response_model.dart';

@Injectable(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyApiService apiService;
  final CurrencyLocalDataSource localService;

  CurrencyRepositoryImpl(this.apiService, this.localService);

  @override
  Future<Either<ServerException, CurrencyConverterEntity>> convertCurrency(
      String baseCurrency, String currenciesChangesTo) async {
    try {
      final convertedCurrency = await apiService.convertCurrency(
          currenciesChangesTo: currenciesChangesTo, baseCurrency: baseCurrency);
      return Right(convertedCurrency);
    } on ServerException catch (failure) {
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      return Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, CurrencyEntity>> getCurrencies() async {
    try {
      final cachedCurrencies = await localService.getCachedCurrencies();
      if (cachedCurrencies != null) {
        return Right(CurrencyResponseModel.fromJson(cachedCurrencies));
      }
      final currencyResponse = await apiService.getCurrencies();
      await localService.cacheCurrencies(currencyResponse.toJson());
      return Right(currencyResponse);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, CurrencyHistoryEntity>> historicalCurrency(
      String baseCurrency, String currenciesChangesTo, String date) async {
    try {
      final historicalCurrency = await apiService.historicalCurrency(
          currenciesChangesTo: currenciesChangesTo,
          baseCurrency: baseCurrency,
          date: date);
      return Right(historicalCurrency);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel: ErrorMessageModel(
              message: "The date must be a date before or equal yesterday")));
    }
  }
}

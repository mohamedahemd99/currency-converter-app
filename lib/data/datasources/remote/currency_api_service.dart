import 'package:currency_converter_app/data/models/currency_converter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/application/constants/endpoints.dart';
import '../../models/currency_history.dart';
import '../../models/currency_response_model.dart';

part 'currency_api_service.g.dart';

@injectable
@RestApi(baseUrl: "https://api.freecurrencyapi.com/v1")
abstract class CurrencyApiService {
  @factoryMethod
  factory CurrencyApiService(Dio dio, {@factoryParam String? baseUrl}) =
      _CurrencyApiService;

  @GET(Endpoints.currencies)
  Future<CurrencyResponseModel> getCurrencies();

  @GET(Endpoints.latest)
  Future<CurrencyConverter> convertCurrency({
    @Query("base_currency") String baseCurrency = 'USD',
    @Query("currencies") required String currenciesChangesTo,
  });

  @GET(Endpoints.historical)
  Future<CurrencyHistory> historicalCurrency({
    @Query("base_currency") String baseCurrency = 'USD',
    @Query("currencies") required String currenciesChangesTo,
    @Query("date") required String date,
  });
}

import 'package:injectable/injectable.dart';

import 'env.dart';

@LazySingleton(as: AppEnvVariables)
class CurrencyConverterEnvVariables implements AppEnvVariables {
  @override
  String get apiKey {
    const apiKey = Env.apikey;
    return apiKey;
  }

  @override
  String get baseUrl => "https://api.freecurrencyapi.com/v1/";
}

abstract class AppEnvVariables {
  String get apiKey;

  String get baseUrl;
}

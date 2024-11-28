import 'package:currency_converter_app/core/application/di/injection.dart';
import 'package:currency_converter_app/core/data/data_sources/env_variables.dart';
import 'package:dio/dio.dart';

class ApiKeyAppenderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = getIt<AppEnvVariables>().apiKey;

    options.queryParameters.addAll({"apikey": apiKey});
    super.onRequest(options, handler);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:currency_converter_app/core/application/di/app_module.dart'
    as _i371;
import 'package:currency_converter_app/core/data/data_sources/env_variables.dart'
    as _i248;
import 'package:currency_converter_app/data/datasources/local/currency_local_datasource.dart'
    as _i356;
import 'package:currency_converter_app/data/datasources/remote/currency_api_service.dart'
    as _i96;
import 'package:currency_converter_app/data/repositories/currency_repository_impl.dart'
    as _i684;
import 'package:currency_converter_app/domain/repositories/currency_repository.dart'
    as _i756;
import 'package:currency_converter_app/domain/usecases/fetch_converted_currency_usecase.dart'
    as _i416;
import 'package:currency_converter_app/domain/usecases/fetch_currency_list_usecase.dart'
    as _i906;
import 'package:currency_converter_app/domain/usecases/fetch_historical_currency_usecase.dart'
    as _i488;
import 'package:currency_converter_app/presentation/bloc/currency_bloc.dart'
    as _i1005;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i356.CurrencyLocalDataSource>(
        () => _i356.CurrencyLocalDataSource());
    gh.lazySingleton<_i248.AppEnvVariables>(
        () => _i248.CurrencyConverterEnvVariables());
    gh.factoryParam<_i96.CurrencyApiService, String?, dynamic>((
      baseUrl,
      _,
    ) =>
        _i96.CurrencyApiService(
          gh<_i361.Dio>(),
          baseUrl: baseUrl,
        ));
    gh.factory<_i756.CurrencyRepository>(() => _i684.CurrencyRepositoryImpl(
          gh<_i96.CurrencyApiService>(),
          gh<_i356.CurrencyLocalDataSource>(),
        ));
    gh.lazySingleton<_i416.FetchConvertedCurrencyUseCase>(() =>
        _i416.FetchConvertedCurrencyUseCase(gh<_i756.CurrencyRepository>()));
    gh.lazySingleton<_i906.GetCurrenciesUseCase>(
        () => _i906.GetCurrenciesUseCase(gh<_i756.CurrencyRepository>()));
    gh.lazySingleton<_i488.FetchHistoricalCurrencyUseCase>(() =>
        _i488.FetchHistoricalCurrencyUseCase(gh<_i756.CurrencyRepository>()));
    gh.factory<_i1005.CurrencyBloc>(() => _i1005.CurrencyBloc(
          gh<_i906.GetCurrenciesUseCase>(),
          gh<_i416.FetchConvertedCurrencyUseCase>(),
          gh<_i488.FetchHistoricalCurrencyUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i371.AppModule {}

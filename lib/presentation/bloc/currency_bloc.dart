import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/fetch_converted_currency_usecase.dart';
import '../../../domain/usecases/fetch_historical_currency_usecase.dart';
import '../../core/application/constants/endpoints.dart';
import '../../core/helper/common.dart';
import '../../domain/usecases/fetch_currency_list_usecase.dart';
import 'currency/currency_event.dart';
import 'currency/currency_states.dart';

@injectable
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrenciesUseCase _getCurrenciesUseCase;
  final FetchConvertedCurrencyUseCase _fetchConvertedCurrencyUseCase;
  final FetchHistoricalCurrencyUseCase _fetchHistoricalCurrencyUseCase;
  DateTime? date;

  Future<void> pickDate(String baseCurrency, String targetCurrency) async {
    final pickedDate = await showDatePicker(
      context: navigatorKey.currentContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      date = pickedDate;
      BlocProvider.of<CurrencyBloc>(navigatorKey.currentContext!).add(
          FetchHistoricalCurrency(
              baseCurrency: baseCurrency,
              targetCurrency: targetCurrency,
              date: formatDateToStartDate(date!)));
    }
  }

  CurrencyBloc(
    this._getCurrenciesUseCase,
    this._fetchConvertedCurrencyUseCase,
    this._fetchHistoricalCurrencyUseCase,
  ) : super(CurrencyInitial()) {
    // Handle FetchCurrencies event
    on<FetchCurrencies>((event, emit) async {
      emit(CurrencyLoading());
      final currencies = await _getCurrenciesUseCase();

      currencies.fold(
        (l) {
          emit(CurrencyError(message: l.errorMessageModel.message ?? ""));
        },
        (r) {
          r.data!
              .map((e) => e.flag =
                  "${Endpoints.flagsBaseUrl}${e.code!.toLowerCase().substring(0, 2)}.png")
              .toList();
          emit(CurrencyLoaded(currencyData: r.data!));
        },
      );
    });

    // Handle ConvertCurrency event
    on<ConvertCurrency>((event, emit) async {
      emit(CurrencyConversionLoading());
      final currencyConverter = await _fetchConvertedCurrencyUseCase(
        baseCurrency: event.baseCurrency,
        currenciesChangesTo: event.targetCurrency,
      );
      currencyConverter.fold(
        (l) {
          emit(CurrencyError(message: l.errorMessageModel.message ?? ""));
        },
        (r) {
          emit(CurrencyConversionLoaded(currencyConversion: r));
        },
      );
    });

    on<FetchHistoricalCurrency>(
      (event, emit) async {
        emit(CurrencyHistoricalLoading());
        final currencyHistory = await _fetchHistoricalCurrencyUseCase(
          baseCurrency: event.baseCurrency,
          currenciesChangesTo: event.targetCurrency,
          date: event.date,
        );
        currencyHistory.fold(
          (l) {
            emit(CurrencyError(message: l.errorMessageModel.message ?? ""));
          },
          (r) {
            emit(CurrencyHistoricalLoaded(currencyHistory: r));
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/currency_entity.dart';
import '../bloc/currency/currency_event.dart';
import '../bloc/currency/currency_states.dart';
import '../bloc/currency_bloc.dart';
import '../widgets/conversion_result.dart';
import '../widgets/convert_button.dart';
import '../widgets/currency_dropdown.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  CurrencyDetail? _baseCurrency;
  CurrencyDetail? _targetCurrency;
  late List<CurrencyDetail> currencies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state is CurrencyLoaded) {
              currencies = state.currencyData;
              _baseCurrency ??= currencies.first;
              _targetCurrency ??= currencies[1];
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  CurrencyDropdown(
                    selectedCurrency: _baseCurrency,
                    currencies: currencies,
                    label: 'Base Currency',
                    onChanged: (value) {
                      _baseCurrency = value;
                      if (_baseCurrency != null && _targetCurrency != null) {
                        BlocProvider.of<CurrencyBloc>(context).add(
                          ConvertCurrency(
                            baseCurrency: _baseCurrency!.code!,
                            targetCurrency: _targetCurrency!.code!,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CurrencyDropdown(
                    selectedCurrency: _targetCurrency,
                    currencies: currencies,
                    label: 'Target Currency',
                    onChanged: (value) {
                      _targetCurrency = value;
                      if (_baseCurrency != null && _targetCurrency != null) {
                        BlocProvider.of<CurrencyBloc>(context).add(
                          ConvertCurrency(
                            baseCurrency: _baseCurrency!.code!,
                            targetCurrency: _targetCurrency!.code!,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (state is CurrencyConversionLoaded)
                    ConversionResult(
                      baseCurrency: _baseCurrency!,
                      targetCurrency: _targetCurrency!,
                      conversionRate:
                          state.currencyConversion.data!.values.first,
                    ),
                  ConvertButton(
                    isLoading: state is CurrencyConversionLoading,
                    onPressed: () {
                      if (_baseCurrency != null && _targetCurrency != null) {
                        BlocProvider.of<CurrencyBloc>(context).add(
                          ConvertCurrency(
                            baseCurrency: _baseCurrency!.code!,
                            targetCurrency: _targetCurrency!.code!,
                          ),
                        );
                      }
                    },
                  ),
                  Spacer(),
                  if (state is CurrencyError) Text(state.message),
                  Text(
                    'Historical Currency',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (state is CurrencyHistoricalLoaded)
                    Text(
                      "date: ${state.currencyHistory.data!.keys.first}",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                  if (state is CurrencyHistoricalLoaded)
                    ConversionResult(
                      baseCurrency: _baseCurrency!,
                      targetCurrency: _targetCurrency!,
                      conversionRate:
                          state.currencyHistory.data!.values.first.values.first,
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_baseCurrency != null && _targetCurrency != null) {
                        BlocProvider.of<CurrencyBloc>(context).pickDate(
                            _baseCurrency!.code!, _targetCurrency!.code!);
                      }
                    },
                    child: Text(
                      state is! CurrencyHistoricalLoaded
                          ? "Select Historical Date"
                          : "Selected Date: ${state.currencyHistory.data!.keys.first}",
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

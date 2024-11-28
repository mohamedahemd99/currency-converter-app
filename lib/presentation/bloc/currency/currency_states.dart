import 'package:currency_converter_app/domain/entities/currency_converter_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/currency_entity.dart';
import '../../../domain/entities/currency_history_entity.dart';

@immutable
abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object?> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyConversionLoading extends CurrencyState {}

class CurrencyHistoricalLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<CurrencyDetail> currencyData;

  const CurrencyLoaded({required this.currencyData});

  @override
  List<Object?> get props => [currencyData];
}

class CurrencyConversionLoaded extends CurrencyState {
  final CurrencyConverterEntity currencyConversion;

  const CurrencyConversionLoaded({required this.currencyConversion});

  @override
  List<Object?> get props => [currencyConversion];
}

class CurrencyHistoricalLoaded extends CurrencyState {
  final CurrencyHistoryEntity currencyHistory;

  const CurrencyHistoricalLoaded({required this.currencyHistory});

  @override
  List<Object?> get props => [currencyHistory];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError({required this.message});

  @override
  List<Object?> get props => [message];
}

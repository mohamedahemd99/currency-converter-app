import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final List<CurrencyDetail>? data;

  const CurrencyEntity({
    this.data,
  });

  @override
  List<Object?> get props => [];
}

class CurrencyDetail {
  final String? symbol;
  final String? name;
  final String? symbolNative;
  final int? decimalDigits;
  final int? rounding;
  final String? code;
  final String? namePlural;
  final String? type;
  String? flag;

  CurrencyDetail({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
    this.type,
    this.flag,
  });
}

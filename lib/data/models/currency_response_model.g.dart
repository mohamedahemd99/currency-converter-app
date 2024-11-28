// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyResponseModel _$CurrencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyResponseModel(
      data: CurrencyResponseModel._mapToDatumList(
          json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$CurrencyResponseModelToJson(
        CurrencyResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      symbolNative: json['symbol_native'] as String?,
      decimalDigits: (json['decimal_digits'] as num?)?.toInt(),
      rounding: (json['rounding'] as num?)?.toInt(),
      code: json['code'] as String?,
      namePlural: json['name_plural'] as String?,
      type: json['type'] as String?,
    )..flag = json['flag'] as String?;

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'flag': instance.flag,
      'symbol': instance.symbol,
      'name': instance.name,
      'symbol_native': instance.symbolNative,
      'decimal_digits': instance.decimalDigits,
      'rounding': instance.rounding,
      'code': instance.code,
      'name_plural': instance.namePlural,
      'type': instance.type,
    };

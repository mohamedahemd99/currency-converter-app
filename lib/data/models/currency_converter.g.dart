// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_converter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyConverter _$CurrencyConverterFromJson(Map<String, dynamic> json) =>
    CurrencyConverter(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CurrencyConverterToJson(CurrencyConverter instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyHistory _$CurrencyHistoryFromJson(Map<String, dynamic> json) =>
    CurrencyHistory(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      ),
    );

Map<String, dynamic> _$CurrencyHistoryToJson(CurrencyHistory instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

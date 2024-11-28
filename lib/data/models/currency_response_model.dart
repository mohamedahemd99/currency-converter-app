import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/currency_entity.dart';

part 'currency_response_model.g.dart'; // Generated file

@JsonSerializable()
class CurrencyResponseModel extends CurrencyEntity {
  @JsonKey(fromJson: _mapToDatumList)
  @override
  final List<Datum>? data;

  CurrencyResponseModel({this.data});

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyResponseModelToJson(this);

  static List<Datum>? _mapToDatumList(Map<String, dynamic>? map) {
    return map?.values.map((item) => Datum.fromJson(item)).toList();
  }
}

@JsonSerializable()
class Datum extends CurrencyDetail {
  @override
  final String? symbol;
  @override
  final String? name;
  @override
  @JsonKey(name: 'symbol_native')
  final String? symbolNative;
  @override
  @JsonKey(name: 'decimal_digits')
  final int? decimalDigits;
  @override
  final int? rounding;
  @override
  final String? code;
  @override
  @JsonKey(name: 'name_plural')
  final String? namePlural;
  @override
  final String? type;
  @override
  Datum({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
    this.type,
  });

  /// Factory constructor to create an object from JSON
  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  /// Method to convert an object to JSON
  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

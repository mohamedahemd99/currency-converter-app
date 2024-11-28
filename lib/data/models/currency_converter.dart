import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/currency_converter_entity.dart';

part 'currency_converter.g.dart'; // Generated file

@JsonSerializable()
class CurrencyConverter extends CurrencyConverterEntity {
  @override
  final Map<String, double>? data;

  const CurrencyConverter({
    this.data,
  });

  /// Factory constructor to create an object from JSON
  factory CurrencyConverter.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConverterFromJson(json);

  /// Method to convert an object to JSON
  Map<String, dynamic> toJson() => _$CurrencyConverterToJson(this);
}

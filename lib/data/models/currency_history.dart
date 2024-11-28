import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/currency_history_entity.dart';

part 'currency_history.g.dart'; // Generated file

@JsonSerializable()
class CurrencyHistory extends CurrencyHistoryEntity {
  final Map<String, Map<String, double>>? data;

  CurrencyHistory({
    this.data,
  });

  /// Factory constructor to create an object from JSON
  factory CurrencyHistory.fromJson(Map<String, dynamic> json) =>
      _$CurrencyHistoryFromJson(json);

  /// Method to convert an object to JSON
  Map<String, dynamic> toJson() => _$CurrencyHistoryToJson(this);
}

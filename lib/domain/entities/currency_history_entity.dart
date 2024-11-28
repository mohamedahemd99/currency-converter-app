import 'package:equatable/equatable.dart';

class CurrencyHistoryEntity extends Equatable {
  final Map<String, Map<String, double>>? data;

  const CurrencyHistoryEntity({
    this.data,
  });

  @override
  List<Object?> get props => [];
}

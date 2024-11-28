import 'package:equatable/equatable.dart';

class CurrencyConverterEntity extends Equatable {
  final Map<String, double>? data;

  const CurrencyConverterEntity({
    this.data,
  });

  @override
  List<Object?> get props => [];
}

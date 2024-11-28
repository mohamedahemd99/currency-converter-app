import 'package:currency_converter_app/presentation/widgets/image_network_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/currency_entity.dart';

class ConversionResult extends StatelessWidget {
  final CurrencyDetail baseCurrency;
  final CurrencyDetail targetCurrency;
  final double conversionRate;

  const ConversionResult({
    super.key,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.conversionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ImageNetworkWidget(imagePath: baseCurrency.flag!),
          Expanded(
            child: FittedBox(
              child: Text(
                "  ${baseCurrency.name} is   ${conversionRate.toStringAsFixed(2)}   to ${targetCurrency.name}  ",
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          ImageNetworkWidget(imagePath: targetCurrency.flag!),
        ],
      ),
    );
  }
}

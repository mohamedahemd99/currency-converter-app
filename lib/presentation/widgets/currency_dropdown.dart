import 'package:flutter/material.dart';

import '../../domain/entities/currency_entity.dart';
import 'image_network_widget.dart';

class CurrencyDropdown extends StatelessWidget {
  final CurrencyDetail? selectedCurrency;
  final List<CurrencyDetail> currencies;
  final String label;
  final ValueChanged<CurrencyDetail?> onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<CurrencyDetail>(
        value: selectedCurrency,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: currencies
            .map((currency) => DropdownMenuItem<CurrencyDetail>(
                  value: currency,
                  child: Row(
                    children: [
                      ImageNetworkWidget(imagePath: currency.flag ?? ""),
                      SizedBox(
                        width: 5,
                      ),
                      Text(currency.name!),
                    ],
                  ),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

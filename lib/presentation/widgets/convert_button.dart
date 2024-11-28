import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ConvertButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: onPressed,
            child: const Text("Convert"),
          );
  }
}

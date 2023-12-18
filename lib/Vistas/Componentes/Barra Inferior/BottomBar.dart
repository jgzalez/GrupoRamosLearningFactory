/// BottomBar.dart
/// A custom bottom bar widget used across the app for consistent UI.
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback? onHelpPressed;

  const BottomBar({Key? key, this.onHelpPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: onHelpPressed,
          color: Theme.of(context).primaryColor, // Ejemplo de uso de tema
        ),
        // Aquí puedes añadir otros elementos de la barra inferior
      ],
    );
  }
}

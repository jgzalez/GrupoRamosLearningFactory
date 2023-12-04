import 'package:flutter/material.dart';

class CreateNewButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CreateNewButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Crear nuevo"),
        onPressed: onPressed,
      ),
    );
  }
}

import 'package:flutter/material.dart';

Align CreateNewButton() {
  return Align(
    alignment: Alignment.topRight,
    child: ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text("Crear nuevo"),
      onPressed: () {},
    ),
  );
}

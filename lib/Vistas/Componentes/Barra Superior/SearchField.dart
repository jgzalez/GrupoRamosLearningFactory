import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final VoidCallback onSearch; // Cambia Function(String) por VoidCallback
  final TextEditingController controller;

  SearchField({Key? key, required this.controller, required this.onSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Buscar',
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed:
              onSearch, // Cambia esto para llamar a onSearch directamente
        ),
      ),
    );
  }
}

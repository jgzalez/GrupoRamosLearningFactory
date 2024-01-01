import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearch;
  const SearchField({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch, // Actualiza el texto de búsqueda aquí
      decoration: InputDecoration(
        hintText: 'Buscar',
        suffixIcon:
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ),
    );
  }
}

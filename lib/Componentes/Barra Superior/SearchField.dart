import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar',
        suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ),
    );
  }
}

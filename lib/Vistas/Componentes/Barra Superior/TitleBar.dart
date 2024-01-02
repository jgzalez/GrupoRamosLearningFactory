import 'package:flutter/material.dart';
import 'package:frontend/Vistas/Componentes/Barra%20Superior/SearchField.dart';

class TitleBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback onSearch;
  final TextEditingController controller; // Añade esto

  const TitleBarWidget({
    super.key,
    required this.title,
    required this.onSearch,
    required this.controller, // Añade esto
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: SearchField(
          onSearch: onSearch,
          controller: controller, // Pasa el controlador aquí
        )), // Ensure that SearchField widget is defined
      ],
    );
  }
}

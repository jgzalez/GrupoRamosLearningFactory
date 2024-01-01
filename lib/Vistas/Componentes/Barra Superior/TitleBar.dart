import 'package:flutter/material.dart';
import 'package:frontend/Vistas/Componentes/Barra%20Superior/SearchField.dart';

class TitleBarWidget extends StatelessWidget {
  final String title;
  final Function(String) onSearch;

  const TitleBarWidget(
      {super.key, required this.title, required this.onSearch});

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
                onSearch:
                    onSearch)), // Ensure that SearchField widget is defined
      ],
    );
  }
}

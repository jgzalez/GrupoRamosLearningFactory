import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Barra%20Superior/SearchField.dart';

class TitleBarWidget extends StatelessWidget {
  final String title;

  const TitleBarWidget({super.key, required this.title});

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
        const Expanded(
            child: SearchField()), // Ensure that SearchField widget is defined
      ],
    );
  }
}

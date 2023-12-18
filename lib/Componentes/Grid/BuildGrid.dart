import 'package:flutter/material.dart';

class GridBuilderWidget extends StatelessWidget {
  final List<Widget> items;

  const GridBuilderWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Número de elementos en el eje transversal
        childAspectRatio: 0.8, // Relación de aspecto de los hijos
        crossAxisSpacing: 10, // Espaciado horizontal entre los elementos
        mainAxisSpacing: 10, // Espaciado vertical entre los elementos
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        // Ahora cada item es un widget completo
        return items[index];
      },
    );
  }
}

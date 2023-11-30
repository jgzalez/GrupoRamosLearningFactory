import 'package:flutter/material.dart';

class GridBuilderWidget extends StatelessWidget {
  final List<String> items;

  const GridBuilderWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(child: Center(child: Text(items[index])));
      },
    );
  }
}

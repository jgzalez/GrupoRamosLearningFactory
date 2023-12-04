import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Grid/CardItem.dart';

class GridBuilderWidget extends StatelessWidget {
  final List<CardItem> items;

  const GridBuilderWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Ajustado para una mejor visualización
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.network(items[index].imageUrl, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(items[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(items[index].creationDate),
                    Text(items[index].author),
                    Text(items[index].description),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

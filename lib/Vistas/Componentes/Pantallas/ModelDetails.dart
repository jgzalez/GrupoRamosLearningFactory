import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Models.dart';

class ModelDetailsPage extends StatelessWidget {
  final Model model;

  const ModelDetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(model.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Categoría:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(model.category, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Fecha de Creación:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(model.creationDate,
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Versión:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(model.version, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Fecha de Actualización:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(model.updateDate, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

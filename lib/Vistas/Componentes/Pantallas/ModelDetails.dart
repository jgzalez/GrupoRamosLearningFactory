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
              // Imagen del modelo
              Container(
                width: double.infinity,
                height: 200, // Ajusta la altura según necesites
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                  image: DecorationImage(
                    image: NetworkImage(model.imageUrl), // URL de la imagen
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Descripción y otros detalles
              _buildDetailSection('Descripción:', model.description),
              _buildDetailSection('Categoría:', model.category),
              _buildDetailSection('Fecha de Creación:', model.creationDate),
              _buildDetailSection('Versión:', model.version),
              _buildDetailSection('Fecha de Actualización:', model.updateDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SelectableText(content, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
      ],
    );
  }
}

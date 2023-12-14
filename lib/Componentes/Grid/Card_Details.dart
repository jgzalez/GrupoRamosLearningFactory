import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Sidebar/Institutions.dart';

class EstablishmentDetailsPage extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentDetailsPage({Key? key, required this.establishment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(establishment.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navegar a la pantalla de edición o mostrar un diálogo de edición
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    establishment.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildDetailText('Título: ', establishment.title),
              buildDetailText(
                  'Fecha de Creación: ', establishment.creationDate),
              buildDetailText('Autor: ', establishment.author),
              buildDetailText('Descripción: ', establishment.description),
              buildDetailText('Ubicación: ', establishment.geographicLocation),
              buildDetailText('Número de Empleados: ',
                  establishment.numberOfEmployees.toString()),
              buildDetailText(
                  'Horarios de Atención: ', establishment.businessHours),
              buildDetailText('Tamaño del Establecimiento: ',
                  establishment.establishmentSize),
              // ... Continuar agregando los demás detalles aquí ...
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        '$label${value ?? "No disponible"}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

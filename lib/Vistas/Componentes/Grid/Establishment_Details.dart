import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Establishment.dart';
import 'package:url_launcher/url_launcher.dart';

class EstablishmentDetailsPage extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentDetailsPage({Key? key, required this.establishment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String placeholderImage =
        'https://images.unsplash.com/photo-1530982011887-3cc11cc85693?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Define la ruta a tu imagen de placeholder

    return Scaffold(
      appBar: AppBar(
        title: SelectableText(establishment.title),
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
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  establishment.imageUrl.isNotEmpty
                      ? establishment.imageUrl
                      : placeholderImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Atributos del Establecimiento:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        buildDetailText('Título: ', establishment.title),
                        buildDetailText(
                            'Fecha de Creación: ', establishment.creationDate),
                        buildDetailText('Autor: ', establishment.author),
                        buildDetailText(
                            'Descripción: ', establishment.description),
                        buildDetailText(
                            'Ubicación: ', establishment.geographicLocation),
                        buildDetailText('Número de Empleados: ',
                            establishment.numberOfEmployees.toString()),
                        buildDetailText('Horarios de Atención: ',
                            establishment.businessHours),
                        buildDetailText('Tamaño del Establecimiento: ',
                            establishment.establishmentSize),
                        buildDetailText(
                            'Flujo de Clientes: ', establishment.customerFlow),
                        buildDetailText('Tipo de Establecimiento: ',
                            establishment.typeOfEstablishment),
                        buildDetailText('Aforo Máximo: ',
                            establishment.maximumCapacity.toString()),
                        buildDetailText(
                            'Año de Fundación: ', establishment.foundationYear),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Archivos Relacionados:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        buildFileLink(context, 'Valoraciones de Clientes: ',
                            establishment.customerRatings),
                        buildFileLink(context, 'Número de Reseñas: ',
                            establishment.numberOfReviews),
                        buildFileLink(context, 'Historial de Ventas: ',
                            establishment.salesHistory),
                        buildFileLink(
                            context,
                            'Datos Demográficos de Clientes: ',
                            establishment.customerDemographics),
                        buildFileLink(context, 'Ingresos Anuales: ',
                            establishment.annualRevenue),
                        buildFileLink(context, 'Gastos Operativos: ',
                            establishment.operationalExpenses),
                        buildFileLink(context, 'Eventos Especiales: ',
                            establishment.specialEvents),
                        buildFileLink(
                            context,
                            'Inventario de Productos/Servicios: ',
                            establishment.inventoryOfProductsServices),
                        buildFileLink(
                            context,
                            'Impacto de Factores Estacionales: ',
                            establishment.seasonalFactorsImpact),
                        buildFileLink(context, 'Competencia Local: ',
                            establishment.localCompetition),
                        buildFileLink(context, 'Tendencias de Mercado: ',
                            establishment.marketTrends),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: SelectableText(
        '$label${value ?? "No disponible"}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildFileLink(BuildContext context, String label, String? url) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: url != null
          ? InkWell(
              child: Text(
                '$label Descargar aquí',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              onTap: () async {
                final uri = Uri.tryParse(url);
                if (uri != null && await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No se puede abrir el archivo')));
                }
              },
            )
          : SelectableText('$label No disponible',
              style: TextStyle(fontSize: 16)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Establishment.dart';
import 'package:url_launcher/url_launcher.dart';

class EstablishmentDetailsPage extends StatelessWidget {
  final Establishment establishment;

  const EstablishmentDetailsPage({Key? key, required this.establishment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrar el título

        title: SelectableText(
          establishment.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Información del Establecimiento:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  buildDetailText('Título: ', establishment.title),
                  buildDetailText('Ubicación: ', establishment.location),
                  buildFileLink(
                      context, 'Área de Deli: ', establishment.deliArea),
                  buildFileLink(
                      context, 'Área de Carnes: ', establishment.carnesArea),
                  buildFileLink(
                      context, 'Área de Cajas: ', establishment.cajasArea),
                  buildFileLink(context, 'Área de Frutas y Verduras: ',
                      establishment.fyvArea),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: SelectableText(
        '$label$value',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildFileLink(BuildContext context, String label, String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: InkWell(
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
      ),
    );
  }
}

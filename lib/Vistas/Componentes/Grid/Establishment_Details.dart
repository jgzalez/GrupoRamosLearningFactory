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
        title: SelectableText(
          "Detalles del Establecimiento",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(establishment.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              height: 200, // Ajusta la altura según necesites
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                image: DecorationImage(
                  image:
                      NetworkImage(establishment.imageUrl), // URL de la imagen
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 75),

            // Widget para la imagen
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // Columna de atributos
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Información del Establecimiento:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          buildDetailText('Título: ', establishment.title),
                          buildDetailText(
                              'Ubicación: ', establishment.location),
                          buildDetailText('Autor: ', establishment.author),

                          // Agrega más atributos aquí
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // Columna de links
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Data de las Areas:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          buildFileLink(context, 'Área de Deli: ',
                              establishment.deliArea),
                          buildFileLink(context, 'Área de Carnes: ',
                              establishment.carnesArea),
                          buildFileLink(context, 'Área de Cajas: ',
                              establishment.cajasArea),
                          buildFileLink(context, 'Área de Frutas y Verduras: ',
                              establishment.fyvArea),
                          // Agrega más links aquí
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

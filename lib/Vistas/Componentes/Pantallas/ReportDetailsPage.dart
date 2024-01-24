import 'package:flutter/material.dart';
import 'package:frontend/Modelos/Reports.dart';

class ReportDetailsPage extends StatelessWidget {
  final Report report;

  const ReportDetailsPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrar el título
        title: Text(
          report.title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
              SelectableText(report.description,
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Categoría:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(report.category, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Fecha de Creación:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(report.creationDate,
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Versión:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(report.version, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(
                'Fecha de Actualización:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SelectableText(report.updateDate, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

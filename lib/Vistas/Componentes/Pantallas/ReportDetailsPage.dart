import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/Modelos/Reports.dart';

class ReportDetailsPage extends StatelessWidget {
  final Report report;

  const ReportDetailsPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              // ... otros Text y SelectableText para mostrar detalles del reporte
              if (report.csvUrl != null && report.csvUrl.isNotEmpty)
                _buildDownloadCsvSection(context, report.csvUrl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadCsvSection(BuildContext context, String csvUrl) {
    return InkWell(
      onTap: () async {
        final uri = Uri.tryParse(csvUrl);
        if (uri != null && await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No se puede abrir el enlace')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'Descargar CSV',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Controladores/createEstablishmentReport.dart';
import 'package:frontend/Modelos/Reports.dart';

class ReportsRegistrationForm extends StatefulWidget {
  final Report? reportToEdit;

  const ReportsRegistrationForm({Key? key, this.reportToEdit})
      : super(key: key);

  @override
  _ReportsRegistrationFormState createState() =>
      _ReportsRegistrationFormState();
}

class _ReportsRegistrationFormState extends State<ReportsRegistrationForm> {
  // Test function for generating a report
  void testCreateReport() async {
    try {
      String testEstablishmentId =
          "establecimientos01"; // Replace with an actual ID
      Map<String, dynamic> report =
          await createEstablishmentReport(testEstablishmentId);
      String jsonString = json.encode(report);
      print("Report generated: $jsonString");
      print("Report generated: $report");
    } catch (e) {
      print("Error testing report generation: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Reportes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Próximamente Solo en Cines",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: testCreateReport,
              child: Text('Test Report Generation'),
            ),
          ],
        ),
      ),
    );
  }
}

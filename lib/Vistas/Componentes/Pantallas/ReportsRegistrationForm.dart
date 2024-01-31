import 'dart:convert';
import 'package:frontend/Modelos/Model1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? selectedEstablishmentId;
  String? selectedModel;
  List<String> establishments = []; // Placeholder list
  List<String> models = []; // Vacía inicialmente, se llenará con datos de la DB
  List<Map<String, String>> establishmentsData = [];

  @override
  void initState() {
    super.initState();
    fetchEstablishments();
    fetchModels(); // Función para cargar modelos desde la DB
  }

  // Test function for generating a report
  void fetchEstablishments() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var snapshot = await firestore.collection('establecimientos').get();
    var fetchedEstablishments = snapshot.docs.map((doc) {
      return {"id": doc.id, "title": doc.data()['title'].toString()};
    }).toList();

    setState(() {
      establishmentsData = fetchedEstablishments;
    });
  }

  void fetchModels() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var snapshot = await firestore.collection('modelos').get();
    var fetchedModels = snapshot.docs.map((doc) {
      return doc
          .data()['title']
          .toString(); // Just get the title, not the whole map
    }).toList();

    setState(() {
      models = fetchedModels;
    });
  }

  void generateReport() async {
    if (selectedEstablishmentId == null || selectedModel == null) {
      print("Please select an establishment and a model");
      return;
    }

    try {
      Map<String, dynamic> report =
          await createEstablishmentReport(selectedEstablishmentId!);
      // await saveReportToFile(report,
      //     'establishment_report.txt'); // Aquí especificas la ruta del archivo
      // Llamar a la función en Model1 para procesar la data
      if (selectedModel == "Tienda Stnd") {
        await Model1.processEstablishmentData(report);
      }
      print(report);

      // Puedes añadir condiciones para otros modelos aquí
    } catch (e) {
      print("Error generating report: $e");
    }
  }

  // void testCreateReport() async {
  //   try {
  //     String testEstablishmentId =
  //         "establecimientos01"; // Replace with an actual ID
  //     Map<String, dynamic> report =
  //         await createEstablishmentReport(testEstablishmentId);
  //     String jsonString = json.encode(report);
  //     print("Report generated: $jsonString");
  //     print("Report generated: $report");
  //   } catch (e) {
  //     print("Error testing report generation: $e");
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Reportes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedEstablishmentId,
              onChanged: (newValue) {
                setState(() {
                  selectedEstablishmentId = newValue;
                  print(selectedEstablishmentId);
                });
              },
              items: establishmentsData
                  .map<DropdownMenuItem<String>>((Map<String, String> value) {
                return DropdownMenuItem<String>(
                  value: value["id"],
                  child: Text(value["title"]!),
                );
              }).toList(),
              hint: Text("Selecciona un Establecimiento"),
            ),
            DropdownButton<String>(
              value: selectedModel,
              onChanged: (newValue) {
                setState(() {
                  selectedModel = newValue;
                });
              },
              items: models.map<DropdownMenuItem<String>>((String title) {
                return DropdownMenuItem<String>(
                  value: title, // Store the model title
                  child: Text(title), // Display the model title
                );
              }).toList(),
              hint: Text("Selecciona un Modelo"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateReport,
              child: Text('Generar Reporte'),
            ),
            // Text(
            //   "Próximamente Solo en Cines",
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: testCreateReport,
            //   child: Text('Test Report Generation'),
            // ),
          ],
        ),
      ),
    );
  }
}

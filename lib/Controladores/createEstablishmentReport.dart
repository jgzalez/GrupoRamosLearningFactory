import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

Future<String> downloadCsvFileContent(String fileUrl) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  String downloadUrl = await storage.ref(fileUrl).getDownloadURL();
  var response = await http.get(Uri.parse(downloadUrl));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to download CSV file');
  }
}

String extractStoragePath(String gsUrl) {
  // This regular expression pattern matches the 'gs://' protocol and the domain
  RegExp pattern = RegExp(r'gs://[^/]+/');

  // Replace the matched part with an empty string to get the relative path
  String storagePath = gsUrl.replaceAll(pattern, '');

  return storagePath;
}

Future<List<Map<String, dynamic>>> parseCsvFile(String fileContent) async {
  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(fileContent);

  // Extract the headers and cast them to String
  List<String> headers = rowsAsListOfValues[0].cast<String>();

  // Convert each row to a Map with String keys
  List<Map<String, dynamic>> mapList = rowsAsListOfValues.sublist(1).map((row) {
    return Map<String, dynamic>.fromIterables(headers, row);
  }).toList();

  return mapList;
}

// Function to fetch establishment data from Firestore
Future<Map<String, dynamic>> fetchEstablishmentData(
    String establishmentId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch the establishment data from Firestore
  DocumentSnapshot snapshot =
      await firestore.collection('establecimientos').doc(establishmentId).get();

  if (!snapshot.exists) {
    throw Exception('Establishment not found');
  }

  return snapshot.data() as Map<String, dynamic>;
}

// Main function to create establishment report
// Función principal para crear el informe del establecimiento
Future<Map<String, dynamic>> createEstablishmentReport(
    String establishmentId) async {
  try {
    // Obtener los datos del establecimiento de Firestore
    Map<String, dynamic> establishmentData =
        await fetchEstablishmentData(establishmentId);

    // Lista de claves que esperamos sean URLs a archivos CSV
    List<String> csvFileKeys = [
      'deliArea',
      'carnesArea',
      'cajasArea',
      'fyvArea',
    ];

    // Crear una estructura para almacenar los datos históricos de cada área
    Map<String, dynamic> historicalData = {};

    // Recorrer cada clave y descargar y analizar el contenido del CSV
    for (String key in csvFileKeys) {
      if (establishmentData.containsKey(key) &&
          establishmentData[key].isNotEmpty) {
        String fileUrl = establishmentData[key];
        String storagePath = extractStoragePath(fileUrl);
        String csvContent = await downloadCsvFileContent(storagePath);
        List<Map<String, dynamic>> fileData = await parseCsvFile(csvContent);

        // Asegúrate de que los tipos de datos sean correctos y consistentes aquí
        // Por ejemplo: convertir valores numéricos a double o int según corresponda

        // Agregar los datos históricos al JSON bajo la clave del área correspondiente
        historicalData[key] = {
          'id': establishmentId,
          'nombreArea': key,
          'dataHistorica': fileData.map((row) {
            // Aquí convertirías y formatearías cada fila según sea necesario
            return row.map((column, value) {
              // Convierte la clave a un string si es necesario
              String columnAsString = column.toString();
              // Convierte el valor al tipo de datos adecuado
              dynamic convertedValue =
                  value; // Aquí deberías hacer la conversión
              return MapEntry(columnAsString, convertedValue);
            });
          }).toList(),
        };
      }
    }

    // Agregar los datos históricos al informe del establecimiento
    establishmentData['historicalData'] = historicalData;

    // Formatea el JSON de salida para tener una estructura clara y consistente
    Map<String, dynamic> formattedJson = {
      'imageUrl': establishmentData['imageUrl'],
      'creationDate': establishmentData['creationDate'],
      'title': establishmentData['title'],
      'description': establishmentData['description'],
      'location': establishmentData['location'],
      'author': establishmentData['author'],
      'historicalData': historicalData,
    };

    return formattedJson;
  } catch (e) {
    print('Error creating establishment report: $e');
    return {};
  }
}

import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class Model1 {
  static Future<void> processEstablishmentData(
      Map<String, dynamic> establishmentData) async {
    // Convertir la data a Excel
    var excelFile = _createExcelFile(establishmentData);

    // Guardar el archivo localmente
    var fileBytes = excelFile.save();
    String filePath = await _saveFileLocally(fileBytes, "report.xlsx");

    // Subir el archivo a Firebase Storage y obtener el URL
    String downloadUrl = await _uploadFileToFirebaseStorage(filePath);

    // Crear un nuevo reporte en Firestore con el URL
    await _createNewReportInFirestore(downloadUrl, establishmentData);
  }

  static Future<String> _saveFileLocally(
      List<int> bytes, String fileName) async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    String filePath = path.join(directory.path, fileName);
    File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  static Excel _createExcelFile(Map<String, dynamic> data) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Agregar encabezados de columnas para campos simples
    var headers = ["Campo", "Valor"];
    sheetObject.appendRow(headers);

    // Agregar la data del establecimiento a la hoja de Excel
    data.forEach((key, value) {
      if (value is! List) {
        // Para campos simples
        var row = [key, value];
        sheetObject.appendRow(row);
      } else {
        // Para campos que son listas
        _addListToSheet(sheetObject, key, value);
      }
    });

    return excel;
  }

  static void _addListToSheet(
      Sheet sheet, String listName, List<dynamic> listData) {
    // Convertir el título de la lista y agregarlo
    sheet.appendRow([listName]);

    // Si la lista está vacía, agregar una fila indicándolo
    if (listData.isEmpty) {
      sheet.appendRow(["No hay datos"]);
      return;
    }

    // Agregar los encabezados y los datos
    var headers = listData.first.keys.toList();
    sheet.appendRow(headers.map((h) => h).toList());

    for (var item in listData) {
      var row = headers.map((h) => item[h]?.toString() ?? '').toList();
      sheet.appendRow(row);
    }

    // Fila en blanco al final
    sheet.appendRow(['']);
  }

  static Future<String> _uploadFileToFirebaseStorage(String filePath) async {
    File file = File(filePath);
    String fileName = path.basename(file.path);
    var storageRef = FirebaseStorage.instance.ref().child('reports/$fileName');
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask;
    return await completedTask.ref.getDownloadURL();
  }

  static Future<void> _createNewReportInFirestore(
      String downloadUrl, Map<String, dynamic> establishmentData) async {
    var report = {
      "title": establishmentData['title'] ?? 'Nuevo Reporte',
      "imageUrl": downloadUrl,
      // Agrega otros campos necesarios
    };
    await FirebaseFirestore.instance.collection('reports').add(report);
  }
}

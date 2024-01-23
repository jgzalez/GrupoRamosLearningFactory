import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data'; // New import for Uint8List

class Model1 {
  static Future<void> processEstablishmentData(
      Map<String, dynamic> establishmentData) async {
    // Convertir la data a Excel
    print(establishmentData);
    var excelFile = _createExcelFile(establishmentData);

    // Guardar el archivo localmente
    var fileBytes = excelFile.save() ?? <int>[];
    Uint8List uint8list = Uint8List.fromList(fileBytes);

    // Subir el archivo a Firebase Storage y obtener el URL
    String downloadUrl =
        await _uploadFileToFirebaseStorage(uint8list, "report.xlsx");

    // Crear un nuevo reporte en Firestore con el URL
    await _createNewReportInFirestore(downloadUrl, establishmentData);
  }

  static Future<String> _uploadFileToFirebaseStorage(
      Uint8List fileData, String fileName) async {
    // Create a reference to Firebase Storage
    Reference storageRef =
        FirebaseStorage.instance.ref().child('reports/$fileName');

    // Upload the file data
    await storageRef.putData(fileData);

    // Get the download URL
    return await storageRef.getDownloadURL();
  }

  static Excel _createExcelFile(Map<String, dynamic> data) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    int rowIndex = 0;

    // Adding headers
    var headers = ["Campo", "Valor"];
    _addRow(sheetObject, rowIndex++, headers);

    // Adding data
    data.forEach((key, value) {
      if (value is List) {
        // Handle lists separately
        _addListToSheet(sheetObject, key, value, rowIndex);
        rowIndex += value.length + 1; // Adjust row index after adding list
      } else {
        // Handle non-list values
        _addRow(sheetObject, rowIndex++, [key, value]);
      }
    });

    return excel;
  }

  static void _addRow(Sheet sheet, int rowIndex, List<dynamic> rowData,
      [List<String>? keys]) {
    for (int columnIndex = 0; columnIndex < rowData.length; columnIndex++) {
      var cellIndex = CellIndex.indexByColumnRow(
          columnIndex: columnIndex, rowIndex: rowIndex);
      var value = rowData[columnIndex];
      var key =
          keys != null && columnIndex < keys.length ? keys[columnIndex] : null;

      if (value is List) {
        // Handling list values
        _addListToSheet(sheet, key ?? "List", value, rowIndex);
      } else {
        // Handling non-list values
        _setCellValue(cellIndex, sheet, value, key);
      }
    }
  }

  static void _setCellValue(
      CellIndex cellIndex, Sheet sheet, dynamic value, String? key) {
    var cell = sheet.cell(cellIndex);

    // Debugging output
    print("Setting value at ${cellIndex.toString()}: $value (key: $key)");

    // Handle null values for all types of fields
    if (value == null) {
      cell.value = TextCellValue(""); // Set empty string for null values
      return; // Skip further processing
    }

    // Assign value based on its type
    if (value is String) {
      cell.value = TextCellValue(value);
    } else if (value is int) {
      cell.value = IntCellValue(value);
    } else if (value is double) {
      cell.value = DoubleCellValue(value);
    } else if (value is bool) {
      cell.value = BoolCellValue(value);
    } else if (value is DateTime) {
      cell.value = DateTimeCellValue(
          year: value.year,
          month: value.month,
          day: value.day,
          hour: value.hour,
          minute: value.minute,
          second: value.second,
          millisecond: value.millisecond);
    } else {
      // Fallback for other types or when the type cannot be determined
      cell.value = TextCellValue(value.toString());
    }
  }

  static void _addListToSheet(
      Sheet sheet, String listName, List<dynamic> listData, int startingRow) {
    // Adding the list name as a header
    _addRow(sheet, startingRow++, [listName]);

    if (listData.isEmpty) {
      _addRow(sheet, startingRow++, ["No hay datos"]);
      return;
    }

    // Adding headers
    var headers = listData.first.keys.toList();
    _addRow(sheet, startingRow++, headers);

    // Adding list data
    for (var item in listData) {
      var row = headers.map((h) => item[h]).toList();
      _addRow(sheet, startingRow++, row);
    }

    // Adding a blank row after the list
    _addRow(sheet, startingRow++, ['']);
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

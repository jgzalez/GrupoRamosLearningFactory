import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data'; // New import for Uint8List

class Model1 {
  static Future<void> processEstablishmentData(
      Map<String, dynamic> establishmentData) async {
    // Convertir la data a CSV
    var csvData = _createCsv(establishmentData);
    print(csvData);

    print("Guardemos el archivo");
    // Guardar el archivo localmente
    var fileBytes = Uint8List.fromList(csvData.codeUnits);
    print("fileBytes listo");

    // Subir el archivo a Firebase Storage y obtener el URL
    String downloadUrl =
        await _uploadFileToFirebaseStorage(fileBytes, "report.csv");

    // Crear un nuevo reporte en Firestore con el URL
    await _createNewReportInFirestore(downloadUrl, establishmentData);
  }

  static Future<void> _createNewReportInFirestore(
      String downloadUrl, Map<String, dynamic> establishmentData) async {
    var report = {
      "title": establishmentData['title'] ?? 'Nuevo Reporte',

      "csvUrl": downloadUrl,

      "imageUrl":
          "https://images.unsplash.com/photo-1591696205602-2f950c417cb9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",

      "description": "Reporte generado de establecimiento " +
          (establishmentData['title'] ?? "existente") +
          " en fecha " +
          DateTime.now().toString()

      // Agrega otros campos necesarios
    };
    print(report);
    await FirebaseFirestore.instance.collection('reportes').add(report);
  }

  static Future<String> _uploadFileToFirebaseStorage(
      Uint8List fileData, String fileName) async {
    print("Lesgooo");
    // Create a reference to Firebase Storage
    Reference storageRef =
        FirebaseStorage.instance.ref().child('reports/$fileName');

    // Upload the file data
    await storageRef.putData(fileData);

    // Get the download URL
    return await storageRef.getDownloadURL();
  }

  static String _createCsv(Map<String, dynamic> data) {
    StringBuffer csvBuffer = StringBuffer();

    // Crear las cabeceras de la tabla
    List<String> headers = [
      "Año",
      "Mes",
      "Tiempo de servicio",
      "Demanda proyectada diaria en unidades",
      "Tiempo proyectado demandado",
      "Tiempo disponible",
      "Cantidad Real de Empleados Requeridos",
      "Cantidad redondeada de empleados",
      "Cantidad de Empleados Actuales",
      "Tipo Tienda",
      "Zona",
      "Monto Venta Promedio" // New header
    ];
    csvBuffer.writeln(headers.join(','));

    // Procesar y agregar los datos históricos
    data['historicalData']?.forEach((areaKey, areaData) {
      if (areaData['dataHistorica'] is List) {
        List<Map<String, dynamic>> historicalData =
            calculateAdditionalColumns(areaData['dataHistorica']);
        historicalData.forEach((row) {
          List<dynamic> rowData = [
            row['Ano '] ?? '',
            row['Mes'] ?? '',
            row['Tiempo de servicio Mes/Ano'] ?? '',
            row['Demanda proyectada diaria en unidades'] ?? '',
            row['Tiempo proyectado demandado'] ?? '',
            row['Tiempo disponible '] ?? '',
            row['Cantidad Real de Empleados Requeridos'] ?? '',
            row['Cantidad redondeada de empleados'] ?? '',
            row['Cantidad de Empleados Actuales'] ?? '',
            row['Tipo Tienda'] ?? '',
            row['Zona'] ?? '',
            row['Monto Venta Promedio'] ?? '', // Add the new column value

            // Agrega aquí los campos adicionales que necesites
          ];
          csvBuffer.writeln(rowData.join(','));
        });
      }
    });

    return csvBuffer.toString();
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
}

// void printExcelContents(Excel excel) {
//   for (var sheet in excel.sheets.keys) {
//     print('Sheet Name: $sheet');
//     print('---------------------------------------------');

//     var sheetObject = excel[sheet];

//     for (var row in sheetObject.rows) {
//       var rowData = row.map((cell) {
//         var value = cell?.value; // Get the value of the cell
//         return value ?? ""; // Return empty string if the cell is null
//       }).join("\t"); // Join the cell values with a tab separator

//       print(rowData); // Print the row data
//     }

//     print('---------------------------------------------\n');
//   }
// }

List<Map<String, dynamic>> calculateAdditionalColumns(
    List<Map<String, dynamic>> historicalData) {
  return historicalData.map((data) {
    print("asdasdasdasd");

    double ventas = double.tryParse(
            data['Ventas del Area'].toString().replaceAll(',', '')) ??
        0;
    print(ventas);
    int tiempoServicio =
        0; // Valor por defecto en caso de que sea nulo o no sea int
    if (data['Tiempo de servicio Mes/Ano'] != null &&
        data['Tiempo de servicio Mes/Ano'] is int) {
      tiempoServicio = data['Tiempo de servicio Mes/Ano'];
    }

    double montoVentaPromedio = 0;
    if (data['Monto Venta Promedio'] != null &&
        data['Monto Venta Promedio'] is int) {
      montoVentaPromedio = data['Monto Venta Promedio'];
    }
    print(tiempoServicio);

    int tiempoDisponible =
        0; // Valor por defecto en caso de que sea nulo o no sea int
    if (data['Tiempo disponible '] != null &&
        data['Tiempo disponible '] is int) {
      tiempoDisponible = data['Tiempo disponible '];
    }

    // Calcula la demanda proyectada diaria en unidades (puedes ajustar esta fórmula según tus necesidades)
    double demandaProyectada = (ventas / montoVentaPromedio) / 30;
    // Asumiendo que las ventas representan la demanda

    // Calcula el tiempo proyectado demandado
    double tiempoProyectadoDemandado = demandaProyectada * tiempoServicio;

    // Calcula la cantidad real de empleados requeridos
    double cantidadEmpleadosRequeridos =
        tiempoProyectadoDemandado / tiempoDisponible;

    // Redondea la cantidad de empleados
    int cantidadRedondeadaEmpleados = cantidadEmpleadosRequeridos.ceil();

    return {
      ...data,
      'Demanda proyectada diaria en unidades': demandaProyectada,
      'Tiempo proyectado demandado': tiempoProyectadoDemandado,
      'Cantidad Real de Empleados Requeridos': cantidadEmpleadosRequeridos,
      'Cantidad redondeada de empleados': cantidadRedondeadaEmpleados,
      'Monto Venta Promedio': montoVentaPromedio, // Add the new field
    };
  }).toList();
}

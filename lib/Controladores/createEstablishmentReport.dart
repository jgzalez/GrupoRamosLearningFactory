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
Future<Map<String, dynamic>> createEstablishmentReport(
    String establishmentId) async {
  try {
    Map<String, dynamic> establishmentData =
        await fetchEstablishmentData(establishmentId);

    // List of keys that are expected to be CSV file URLs
    List<String> csvFileKeys = [
      'marketTrends',
      'customerDemographics',
    ];

    for (String key in csvFileKeys) {
      if (establishmentData.containsKey(key) &&
          establishmentData[key].endsWith('.csv')) {
        String fileUrl = establishmentData[key];
        String storagePath = extractStoragePath(
            fileUrl); // Implement this function to extract the path from the gs:// URL
        String csvContent = await downloadCsvFileContent(storagePath);
        var fileData = await parseCsvFile(csvContent); // Pass csvContent here
        establishmentData[key] = fileData;
      }
    }

    return establishmentData;
  } catch (e) {
    print('Error creating establishment report: $e');
    return {};
  }
}

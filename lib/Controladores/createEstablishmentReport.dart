import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;


Future<String> downloadCsvFileContent(String fileUrl) async {
  var response = await http.get(Uri.parse(fileUrl));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to download CSV file');
  }
}

Future<List<Map<String, dynamic>>> parseCsvFile(String fileContent) async {
  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(fileContent);

  // Extract the headers and cast them to String
  List<String> headers = rowsAsListOfValues[0].cast<String>();

  // Convert each row to a Map with String keys
  List<Map<String, dynamic>> mapList = rowsAsListOfValues.sublist(1).map((row) {
    return Map<String, dynamic>.fromIterables(headers, row);
  }).toList();

  return mapList;
}


// Function to fetch establishment data from Firestore
Future<Map<String, dynamic>> fetchEstablishmentData(String establishmentId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch the establishment data from Firestore
  DocumentSnapshot snapshot = await firestore.collection('establishments').doc(establishmentId).get();

  if (!snapshot.exists) {
    throw Exception('Establishment not found');
  }

  return snapshot.data() as Map<String, dynamic>;
}

// Main function to create establishment report
Future<Map<String, dynamic>> createEstablishmentReport(String establishmentId) async {
  try {
    Map<String, dynamic> establishmentData = await fetchEstablishmentData(establishmentId);

    // List of keys that are expected to be CSV file URLs
    List<String> csvFileKeys = [
      'customerRatings',
      'numberOfReviews',
      // Add other keys that reference CSV files
    ];

    for (String key in csvFileKeys) {
      if (establishmentData.containsKey(key) && establishmentData[key].endsWith('.csv')) 
      {
      String fileUrl = establishmentData[key];
      String csvContent = await downloadCsvFileContent(fileUrl);
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


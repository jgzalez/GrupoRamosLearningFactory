import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String title;
  final String description;
  final String author;
  final String category;
  final String creationDate;
  final String location;
  final String version;
  final String updateDate;
  final String imageUrl;
  final String csvUrl; // Campo csvUrl agregado

  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.category,
    required this.creationDate,
    required this.location,
    required this.version,
    required this.updateDate,
    required this.imageUrl,
    required this.csvUrl, // Inicialización de csvUrl
  });

  factory Report.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Report(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      author: data['author'] ?? '',
      category: data['category'] ?? '',
      creationDate: data['creationDate'] ?? '',
      location: data['location'] ?? '',
      version: data['version'] ?? '',
      updateDate: data['updateDate'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      csvUrl: data['csvUrl'] ?? '', // Obtener csvUrl del documento
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'category': category,
      'creationDate': creationDate,
      'location': location,
      'version': version,
      'updateDate': updateDate,
      'imageUrl': imageUrl,
      'csvUrl': csvUrl, // Agregar csvUrl al mapa
    };
  }
}

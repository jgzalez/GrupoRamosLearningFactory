import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String title;
  final String description;
  final String author;
  final String category;
  final String creationDate;
  final String version;
  final String updateDate;

  var imageUrl;

  Report({
    required this.title,
    required this.id,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.creationDate,
    required this.version,
    required this.updateDate,
  });

  // Método para convertir un documento de Firestore en un objeto Model
  factory Report.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Report(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      creationDate: data['creationDate'] ?? '',
      version: data['version'] ?? '',
      updateDate: data['updateDate'] ?? '',
    );
  }

  // Método para convertir un objeto Model en un mapa, útil para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'creationDate': creationDate,
      'version': version,
      'updateDate': updateDate,
    };
  }
}

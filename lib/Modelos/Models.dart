import 'package:cloud_firestore/cloud_firestore.dart';

class Model {
  final String title;
  final String description;
  final String author;
  final String category;
  final String creationDate;
  final String version;
  final String updateDate;

  var imageUrl;

  Model({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.creationDate,
    required this.version,
    required this.updateDate,
  });

  // Método para convertir un documento de Firestore en un objeto Model
  factory Model.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return Model(
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

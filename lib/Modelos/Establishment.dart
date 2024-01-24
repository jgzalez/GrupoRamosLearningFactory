import 'package:cloud_firestore/cloud_firestore.dart';

class Establishment {
  String id;
  String title;
  String location;
  String deliArea; // URL a un archivo CSV en Storage
  String carnesArea; // URL a un archivo CSV en Storage
  String cajasArea; // URL a un archivo CSV en Storage
  String fyvArea; // URL a un archivo CSV en Storage

  // Agrega estos nuevos campos
  final String imageUrl;
  final String creationDate;
  final String description;
  final String author;

  Establishment({
    required this.id,
    required this.title,
    required this.location,
    required this.deliArea,
    required this.carnesArea,
    required this.cajasArea,
    required this.fyvArea,
    required this.imageUrl,
    required this.creationDate,
    required this.description,
    required this.author,
  });

  factory Establishment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Establishment(
      id: doc.id,
      title: data['title'] ?? 'Tienda',
      location: data['location'] ?? 'Ubicación predeterminada',
      deliArea: data['deliArea'] ?? 'URL del área Deli predeterminada',
      carnesArea: data['carnesArea'] ?? 'URL del área Carnes predeterminada',
      cajasArea: data['cajasArea'] ?? 'URL del área Cajas predeterminada',
      fyvArea: data['fyvArea'] ?? 'URL del área FyV predeterminada',
      imageUrl: data['imageUrl'] ?? 'URL de imagen predeterminada',
      creationDate: data['creationDate'] ?? 'Fecha predeterminada',
      description: data['description'] ?? 'Descripción predeterminada',
      author: data['author'] ?? 'Autor predeterminado',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'deliArea': deliArea,
      'carnesArea': carnesArea,
      'cajasArea': cajasArea,
      'fyvArea': fyvArea,
    };
  }
}

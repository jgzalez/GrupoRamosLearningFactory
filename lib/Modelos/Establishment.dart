import 'package:cloud_firestore/cloud_firestore.dart';

class Establishment {
  String id;
  String title;
  String location;
  String deliArea; // URL a un archivo CSV en Storage
  String carnesArea; // URL a un archivo CSV en Storage
  String cajasArea; // URL a un archivo CSV en Storage
  String fyvArea; // URL a un archivo CSV en Storage
  String categoria;

  // Agrega estos nuevos campos
  final String imageUrl;
  final String creationDate;
  final String description;
  final String author;

  Establishment({
    required this.id,
    required this.title,
    required this.categoria,
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
      categoria: data['categoria'] ?? 'Tienda',
      title: data['title'] ?? 'Tienda',
      location: data['location'] ?? 'Ubicación no Registrada',
      deliArea:
          data['deliArea'] ?? 'No se ha definido la Data del Área de Deli',
      carnesArea:
          data['carnesArea'] ?? 'No se ha definido la Data del Área de Carnes',
      cajasArea:
          data['cajasArea'] ?? 'No se ha definido la Data del Área de Cajas',
      fyvArea: data['fyvArea'] ?? 'No se ha definido la Data del Área de FyV',
      imageUrl: data['imageUrl'] ??
          'https://thefoodtech.com/wp-content/uploads/2020/05/Mi-tienda-segura-828x548.jpg',
      creationDate: data['creationDate'] ?? 'Fecha predeterminada',
      description: data['description'] ?? 'Descripción predeterminada',
      author: data['author'] ?? 'INGENIO',
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
      'imageUrl': imageUrl,
      'creationDate': creationDate,
      'description': description,
      'author': author,
    };
  }
}

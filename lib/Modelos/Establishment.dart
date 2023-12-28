// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Establishment {
  final String id;
  final String title;
  final String imageUrl;
  final String creationDate;
  final String author;
  final String description;
  final String name;
  final String geographicLocation;
  final int numberOfEmployees;
  final String businessHours;
  final String establishmentSize;
  final String customerFlow;
  final String typeOfEstablishment;
  final int maximumCapacity;
  final String foundationYear;
  var customerRatings; // Archivo
  var numberOfReviews; // Archivo
  var salesHistory; // Archivo
  var customerDemographics; // Archivo
  var annualRevenue; // Archivo
  var operationalExpenses; // Archivo
  var specialEvents; // Archivo
  var inventoryOfProductsServices; // Archivo
  var seasonalFactorsImpact; // Archivo
  var localCompetition; // Archivo
  var marketTrends;

  Establishment({
    required this.id,
    required this.title,
    required this.author,
    required this.creationDate,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.geographicLocation,
    required this.numberOfEmployees,
    required this.businessHours,
    required this.establishmentSize,
    required this.customerFlow,
    required this.typeOfEstablishment,
    required this.maximumCapacity,
    required this.foundationYear,
    this.customerRatings,
    this.numberOfReviews,
    this.salesHistory,
    this.customerDemographics,
    this.annualRevenue,
    this.operationalExpenses,
    this.specialEvents,
    this.inventoryOfProductsServices,
    this.seasonalFactorsImpact,
    this.localCompetition,
    this.marketTrends,
  });

  factory Establishment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Establishment(
      id: doc.id,
      title: data['title'] ?? 'Título predeterminado',
      name: data['name'] ?? 'Nombre predeterminado',
      author: data['author'] ?? 'Autor predeterminado',
      description: data['description'] ?? 'Descripción predeterminada',
      imageUrl: data['imageUrl'] ?? 'URL de imagen predeterminada',
      creationDate: data['creationDate'] ?? 'Fecha predeterminada',
      geographicLocation:
          data['geographicLocation'] ?? 'Ubicación Geográfica predeterminada',
      numberOfEmployees:
          data['numberOfEmployees'] ?? 0, // Asumiendo que es un entero
      businessHours:
          data['businessHours'] ?? 'Horarios de negocios predeterminados',
      establishmentSize: data['establishmentSize'] ??
          'Tamaño del establecimiento predeterminado',
      customerFlow: data['customerFlow'] ?? 'Flujo de clientes predeterminado',
      typeOfEstablishment: data['typeOfEstablishment'] ??
          'Tipo de establecimiento predeterminado',
      maximumCapacity:
          data['maximumCapacity'] ?? 0, // Asumiendo que es un entero
      foundationYear:
          data['foundationYear'] ?? 'Año de fundación predeterminado',
      customerRatings: data['customerRatings'], // Puede ser nulo
      numberOfReviews: data['numberOfReviews'], // Puede ser nulo
      salesHistory: data['salesHistory'], // Puede ser nulo
      customerDemographics: data['customerDemographics'], // Puede ser nulo
      annualRevenue: data['annualRevenue'], // Puede ser nulo
      operationalExpenses: data['operationalExpenses'], // Puede ser nulo
      specialEvents: data['specialEvents'], // Puede ser nulo
      inventoryOfProductsServices:
          data['inventoryOfProductsServices'], // Puede ser nulo
      seasonalFactorsImpact: data['seasonalFactorsImpact'], // Puede ser nulo
      localCompetition: data['localCompetition'], // Puede ser nulo
      marketTrends: data['marketTrends'], // Puede ser nulo
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'creationDate': creationDate,
      'author': author,
      'description': description,
      'name': name,
      'geographicLocation': geographicLocation,
      'numberOfEmployees': numberOfEmployees,
      'businessHours': businessHours,
      'establishmentSize': establishmentSize,
      'customerFlow': customerFlow,
      'typeOfEstablishment': typeOfEstablishment,
      'maximumCapacity': maximumCapacity,
      'foundationYear': foundationYear,
      'customerRatings': customerRatings,
      'numberOfReviews': numberOfReviews,
      'salesHistory': salesHistory,
      'customerDemographics': customerDemographics,
      'annualRevenue': annualRevenue,
      'operationalExpenses': operationalExpenses,
      'specialEvents': specialEvents,
      'inventoryOfProductsServices': inventoryOfProductsServices,
      'seasonalFactorsImpact': seasonalFactorsImpact,
      'localCompetition': localCompetition,
      'marketTrends': marketTrends,
    };
  }
}

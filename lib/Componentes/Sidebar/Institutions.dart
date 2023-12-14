class Establishment {
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
  final String? customerRatings; // Archivo
  final int? numberOfReviews; // Archivo
  final String? salesHistory; // Archivo
  final String? customerDemographics; // Archivo
  final String? annualRevenue; // Archivo
  final String? operationalExpenses; // Archivo
  final String? specialEvents; // Archivo
  final String? inventoryOfProductsServices; // Archivo
  final String? seasonalFactorsImpact; // Archivo
  final String? localCompetition; // Archivo
  final String? marketTrends; // Archivo

  Establishment({
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

  factory Establishment.fromMap(Map<String, dynamic> data) {
    return Establishment(
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

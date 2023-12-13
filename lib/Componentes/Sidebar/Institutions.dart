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
      title: data['title'],
      name: data['name'],
      author: data['author'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      creationDate: data['creationDate'],
      geographicLocation: data['geographicLocation'],
      numberOfEmployees: data['numberOfEmployees'],
      businessHours: data['businessHours'],
      establishmentSize: data['establishmentSize'],
      customerFlow: data['customerFlow'],
      typeOfEstablishment: data['typeOfEstablishment'],
      maximumCapacity: data['maximumCapacity'],
      foundationYear: data['foundationYear'],
      customerRatings: data['customerRatings'],
      numberOfReviews: data['numberOfReviews'],
      salesHistory: data['salesHistory'],
      customerDemographics: data['customerDemographics'],
      annualRevenue: data['annualRevenue'],
      operationalExpenses: data['operationalExpenses'],
      specialEvents: data['specialEvents'],
      inventoryOfProductsServices: data['inventoryOfProductsServices'],
      seasonalFactorsImpact: data['seasonalFactorsImpact'],
      localCompetition: data['localCompetition'],
      marketTrends: data['marketTrends'],
    );
  }
}

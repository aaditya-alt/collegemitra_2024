class CollegeData {
  String shortName;
  String state;
  String address;
  String nearbyAirport;
  String nearbyRailway;
  String nearbyBus;
  String accreditation;
  String campusArea;
  String averagePackage;
  String highestPackage;
  String mainImage;

  // Companies
  Map<String, String> companies;

  // Branch Details
  List<String> selectedBranches;
  Map<String, Map<String, dynamic>>
      branchDetails; // Map to store details for each branch

  // Hostel Details
  bool boysHostel;
  bool girlsHostel;
  double boysHostelFee;
  double girlsHostelFee;

  // Facilities
  Map<String, bool> facilities;

  CollegeData({
    required this.shortName,
    required this.state,
    required this.address,
    required this.nearbyAirport,
    required this.nearbyRailway,
    required this.nearbyBus,
    required this.accreditation,
    required this.campusArea,
    required this.averagePackage,
    required this.highestPackage,
    required this.mainImage,
    required this.companies,
    required this.selectedBranches,
    required this.branchDetails,
    required this.boysHostel,
    required this.girlsHostel,
    required this.boysHostelFee,
    required this.girlsHostelFee,
    required this.facilities,
  });

  // You can add methods to convert the data to JSON for database storage if needed
  Map<String, dynamic> toJson() {
    return {
      'shortName': shortName,
      'state': state,
      'address': address,
      'nearbyAirport': nearbyAirport,
      'nearbyRailway': nearbyRailway,
      'nearbyBus': nearbyBus,
      'accreditation': accreditation,
      'campusArea': campusArea,
      'averagePackage': averagePackage,
      'highestPackage': highestPackage,
      'mainImage': mainImage,
      'companies': companies,
      'selectedBranches': selectedBranches,
      'branchDetails': branchDetails,
      'boysHostel': boysHostel,
      'girlsHostel': girlsHostel,
      'boysHostelFee': boysHostelFee,
      'girlsHostelFee': girlsHostelFee,
      'facilities': facilities,
    };
  }
}

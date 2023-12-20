import 'dart:convert';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class AllColleges {
  String collegeName;
  String collegeType;
  String collegeState;
  String collegeImage;
  int collegeId;

  AllColleges({
    required this.collegeName,
    required this.collegeType,
    required this.collegeState,
    required this.collegeImage,
    required this.collegeId,
  });
}

class CollegeDetails {
  String collegeShortName;
  String collegeFullName;
  String nearbyAirport;
  String nearbyRailway;
  String nearbyBus;
  String foundedIn;
  String ranking;
  String description;
  String highestPackage;
  String averagePackage;
  String boysHostelFee;
  String girlsHostelFee;
  List<String> imageUrlString;
  String collegeImage;
  List<String> companyImages;
  String phone;
  String email;
  String website;
  String campusArea;
  String address;
  List<Branch> branchesFees;
  List<String> videoLinks;

  CollegeDetails({
    required this.collegeShortName,
    required this.collegeFullName,
    required this.nearbyAirport,
    required this.nearbyRailway,
    required this.nearbyBus,
    required this.foundedIn,
    required this.ranking,
    required this.description,
    required this.highestPackage,
    required this.averagePackage,
    required this.boysHostelFee,
    required this.girlsHostelFee,
    required this.imageUrlString,
    required this.collegeImage,
    required this.companyImages,
    required this.address,
    required this.campusArea,
    required this.website,
    required this.email,
    required this.phone,
    required this.branchesFees,
    required this.videoLinks,
  });
}

class Branch {
  String branchName;
  String fee;
  String percentagePlacement;

  Branch(
      {required this.branchName,
      required this.fee,
      required this.percentagePlacement});
}

class Cutoff {
  String branchName;
  String closingRank;

  Cutoff({
    required this.branchName,
    required this.closingRank,
  });
}

Future<List<CollegeDetails>> getCollegeDetailsList(int collegeId) async {
  final supabase = Supabase.instance.client;
  final response =
      await supabase.from("college_details").select().eq("id", collegeId);

  final List<dynamic>? data = response is List ? response : response['data'];

  if (data == null || data.isEmpty) {
    return [];
  }

  final List<CollegeDetails> collegeDetails = data.map<CollegeDetails>((row) {
    final List<String> collegeImages = (row['images'].toString())
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();

    final List<String> companyImages = (row['companies'].toString())
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();

    final List<String> videoLinksYoutube = (row['video_links'].toString())
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();

    final Map<String, dynamic> branchesFeesMap =
        json.decode(row['branches_fees']);

    final Map<String, dynamic> branchesPlacementMap =
        json.decode(row['branches_percentage']);

    final List<Branch> branchesFees = branchesFeesMap['branches']
            ?.entries
            .map<Branch>((entry) => Branch(
                  branchName: entry.key,
                  fee: entry.value,
                  percentagePlacement:
                      branchesPlacementMap[entry.key]?.toString() ?? "80%",
                ))
            .toList() ??
        [];

    return CollegeDetails(
      collegeShortName: row['short_name'].toString(),
      collegeFullName: row['full_name'].toString(),
      nearbyAirport: row['nearby_airport'].toString(),
      nearbyRailway: row['nearby_railway'].toString(),
      nearbyBus: row['nearby_bus'],
      highestPackage: row['highest_package'].toString(),
      averagePackage: row['average_package'].toString(),
      boysHostelFee: row['boys_hostel_fee'].toString(),
      girlsHostelFee: row['girls_hostel_fee'].toString(),
      foundedIn: row['founded_in'].toString(),
      ranking: row['ranking'].toString(),
      description: row['description'].toString(),
      address: row['address'].toString(),
      website: row['website'].toString(),
      phone: row['phone'].toString(),
      email: row['email'].toString(),
      campusArea: row['campus_area'].toString(),
      collegeImage: row['main_image'].toString(),
      imageUrlString: collegeImages,
      companyImages: companyImages,
      branchesFees: branchesFees,
      videoLinks: videoLinksYoutube,
    );
  }).toList();

  print(collegeDetails[0]);

  return collegeDetails;
}

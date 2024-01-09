import 'dart:convert';

import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollegeDetailsCMSController extends GetxController {
  static CollegeDetailsCMSController get instance => Get.find();
  final supabase = Supabase.instance.client;

  final excelController = ExcelCollegePredictor();

  /// TextField Controllers to get data from TextFields
  final shortName = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final nearbyAirport = TextEditingController();
  final nearbyRailway = TextEditingController();
  final nearbyBus = TextEditingController();
  final ranking = TextEditingController();
  final type = TextEditingController();
  final accreditation = TextEditingController();
  final campusArea = TextEditingController();
  final averagePackage = TextEditingController();
  final highestPackage = TextEditingController();
  final mainImage = TextEditingController();
  final images = TextEditingController();
  final fees = TextEditingController();
  final boysHostelFee = TextEditingController();
  final girlsHostelFee = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final website = TextEditingController();
  final companiesName = TextEditingController();
  final branchHighestPackage = TextEditingController();
  final branchAveragePackage = TextEditingController();
  final branchPercentagePlacement = TextEditingController();
  final branchSeats = TextEditingController();
  final uploadedBy = TextEditingController();
  final description = TextEditingController();
  final establishedIn = TextEditingController();
  final videoLinks = TextEditingController();
  final companyImagesController = TextEditingController();

  storeCollegeDetailsToSupabase(fullName, counselling, companies, branchesFees,
      facilities, branchWisePlacements) async {
    await supabase.from("college_details").insert({
      'full_name': fullName,
      'short_name': shortName.text,
      'counselling': counselling,
      'state': state.text,
      'address': address.text,
      'nearby_airport': nearbyAirport.text,
      'nearby_railway': nearbyRailway.text,
      'nearby_bus': nearbyBus.text,
      'ranking': ranking.text,
      'type': type.text,
      'accreditation': accreditation.text,
      'campus_area': campusArea.text,
      'average_package': averagePackage.text,
      'highest_package': highestPackage.text,
      'companies': companies,
      'main_image': mainImage.text,
      'images': images.text,
      'branches_fees': branchesFees,
      'boys_hostel_fee': boysHostelFee.text,
      'girls_hostel_fee': girlsHostelFee.text,
      'facilities': facilities,
      'phone': phone.text,
      'email': email.text,
      'website': website.text,
      'branches_percentage': branchWisePlacements,
      'uploaded_by': uploadedBy.text,
      // ignore: equal_keys_in_map
      'type': type.text,
      'description': description.text,
      'founded_in': establishedIn.text,
      'video_links': videoLinks.text,
    });
  }

  Future<SnackbarController> populateCollegeDetailsFromSupabase(
      String fullName, callBack) async {
    final response = await supabase
        .from("college_details")
        .select()
        .eq('full_name', fullName);

    final List<dynamic>? data = response is List ? response : response['data'];

    if (data == null || data.isEmpty) {
      // Return an empty list if there is no data
      return Get.snackbar(
        'Error',
        "Please Enter the new details for this College",
      );
    } else {
      // Assuming you have the reference to your controller in your widget
      shortName.text = data[0]['short_name'].toString();
      state.text = data[0]['state'].toString();
      address.text = data[0]['address'].toString();
      nearbyAirport.text = data[0]['nearby_airport'].toString();
      nearbyRailway.text = data[0]['nearby_railway'].toString();
      nearbyBus.text = data[0]['nearby_bus'].toString();
      ranking.text = data[0]['ranking'].toString();
      type.text = data[0]['type'].toString();
      accreditation.text = data[0]['accreditation'].toString();
      campusArea.text = data[0]['campus_area'].toString();
      averagePackage.text = data[0]['average_package'].toString();
      highestPackage.text = data[0]['highest_package'].toString();
      boysHostelFee.text = data[0]['boys_hostel_fee'].toString();
      girlsHostelFee.text = data[0]['girls_hostel_fee'].toString();
      phone.text = data[0]['phone'].toString();
      email.text = data[0]['email'].toString();
      website.text = data[0]['website'].toString();
      uploadedBy.text = data[0]['uploaded_by'].toString();
      description.text = data[0]['description'].toString();
      establishedIn.text = data[0]['founded_in'].toString();
      videoLinks.text = data[0]['video_links'].toString();
      mainImage.text = data[0]['main_image'].toString();
      images.text = data[0]['images'].toString();
      companyImagesController.text = data[0]['companies'].toString();
      callBack(data[0]['branches_percentage'].toString());

      // Ensure the text fields are populated before proceeding
      await Future.delayed(const Duration(milliseconds: 150));
      print(establishedIn.text);
      return Get.snackbar('success', 'Data has been inserted into textfields');
    }
  }

  updateCollegeDetailsToSupabase(fullName, counselling, companies, branchesFees,
      facilities, branchWisePlacements) async {
    await supabase.from("college_details").update({
      'full_name': fullName,
      'short_name': shortName.text,
      'counselling': counselling,
      'state': state.text,
      'address': address.text,
      'nearby_airport': nearbyAirport.text,
      'nearby_railway': nearbyRailway.text,
      'nearby_bus': nearbyBus.text,
      'ranking': ranking.text,
      'type': type.text,
      'accreditation': accreditation.text,
      'campus_area': campusArea.text,
      'average_package': averagePackage.text,
      'highest_package': highestPackage.text,
      'companies': companies,
      'main_image': mainImage.text,
      'images': images.text,
      'branches_fees': branchesFees,
      'boys_hostel_fee': boysHostelFee.text,
      'girls_hostel_fee': girlsHostelFee.text,
      'facilities': facilities,
      'phone': phone.text,
      'email': email.text,
      'website': website.text,
      'branches_percentage': branchWisePlacements,
      'uploaded_by': uploadedBy.text,
      // ignore: equal_keys_in_map
      'type': type.text,
      'description': description.text,
      'founded_in': establishedIn.text,
      'video_links': videoLinks.text,
    }).eq('full_name', fullName);
  }

  void populatePlacementPercentages(String jsonString, callBack) {
    try {
      // Parse the JSON string
      Map<String, dynamic> placementData = jsonDecode(jsonString);

      callBack(placementData);
    } catch (e) {
      print("Error parsing JSON for placement percentages: $e");
    }
  }
}

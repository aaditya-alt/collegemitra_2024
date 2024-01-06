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

  storeCollegeDetailsToSupabase(fullName, counselling, companies, branchesFees,
      facilities, branchWisePlacements) async {
    print("Hey, data reached the controller");
    print("Companies Array : $companies");
    print("Facilities JSON : $facilities");
    print("Branches Fees JSON : $branchesFees");
    print("Branches Placements : $branchWisePlacements");
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
    });
  }
}

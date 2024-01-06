import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollegePredictorController extends GetxController {
  static CollegePredictorController get instance => Get.find();

  // final collegePredictorRepo = Get.put(CollegePredictorRepository());

  final excelCollegePredictorRepo = Get.put(ExcelCollegePredictor());

  /// TextField Controllers to get data from TextFields
  final userRank = TextEditingController();

  printDetails(domicile, category, subCategory, userRank, counselling) {
    print(
        "$domicile \n $category \n $subCategory \n $userRank \n $counselling");
  }

  predictColleges(
      counselling, category, subCategory, int rank, domicile) async {
    // final data = await collegePredictorRepo.fetchCollegesAndRounds(
    //     counselling, category, subCategory, rank);

    // print(data.length);
    // Get.to(() => ShowColleges(
    //       collegesToShow: data,
    //       counsellingName: counselling.toString(),
    //       userDetails: [
    //         counselling,
    //         domicile,
    //         category,
    //         subCategory,
    //         rank.toString()
    //       ],
    //     ));
  }

  predictCollegesUsingExcel(String counselling, String category,
      String subCategory, int rank, String domicile, String exam) async {
    final data = await excelCollegePredictorRepo.processExcelData(
        domicile, category, subCategory, rank, counselling, exam);

    print("Got the data in controller");

    return data;
  }

  Future<List<String>> getBranchesUsingExcel(String counselling) async {
    final data =
        await excelCollegePredictorRepo.getBranchesFromCounselling(counselling);
    return data;
  }

  getCollegesByBranches(
      String state,
      String category,
      String gender,
      int userRank,
      String counselling,
      String exam,
      List<String> selectedBranches) async {
    final data = await excelCollegePredictorRepo.getCollegesForBranches(
        state, category, gender, userRank, counselling, exam, selectedBranches);

    print("Got data in controller");
    return data;
  }
}

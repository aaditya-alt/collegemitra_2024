import 'dart:ffi';

import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_colleges.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/college_predictor_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollegePredictorController extends GetxController {
  static CollegePredictorController get instance => Get.find();

  final collegePredictorRepo = Get.put(CollegePredictorRepository());

  final excelCollegePredictorRepo = Get.put(ExcelCollegePredictor());

  List<DropdownMenuEntry<dynamic>> finalDomicileList = [
    const DropdownMenuEntry(
        value: 'Select State', label: 'Select State', enabled: false),
  ];

  RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  /// TextField Controllers to get data from TextFields
  final domicile = TextEditingController();
  final category = TextEditingController();
  final subCategory = TextEditingController();
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

  predictCollegesUsingExcel(
      counselling, category, subCategory, rank, domicile) async {
    final data = await excelCollegePredictorRepo.processExcelData(
        domicile, category, subCategory, rank);
    // final stateData =
    //     await excelCollegePredictorRepo.getStateDataToPopulate(counselling);

    // finalDomicileList.clear();

    // for (var state in stateData) {
    //   finalDomicileList.add(state);
    // }

    Get.to(() => ShowColleges(
          collegesToShow: data,
          counsellingName: counselling.toString(),
          userDetails: [
            counselling,
            domicile,
            category,
            subCategory,
            rank.toString()
          ],
        ));
  }
}

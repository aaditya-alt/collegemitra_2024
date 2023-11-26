import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_colleges.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/college_predictor_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankPredictorController extends GetxController {
  static RankPredictorController get instance => Get.find();

  RxBool isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  /// TextField Controllers to get data from TextFields
  final marks = TextEditingController();

  //debug values
  printDetails(date, shift, marks) {
    print("Date is $date \n Shift is $shift \n Marks is $marks");
  }
}

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

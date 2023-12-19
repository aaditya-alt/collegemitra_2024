import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';

Future<List<String>> getCollegesList(String counselling) async {
  await Future.delayed(const Duration(seconds: 2));
  List<String> colleges = [];
  final excel = ExcelCollegePredictor();

  final data = await excel.getCollegesFromCounselling(counselling);
  colleges.addAll(data);

  return colleges;
}

Future<List<String>> getBranchesList(String college, String counselling) async {
  await Future.delayed(const Duration(seconds: 2));
  List<String> branches = [];
  final excel = ExcelCollegePredictor();

  final data = await excel.getBranchesFromColleges(college, counselling);
  branches.addAll(data);

  return branches;
}

String toJson(Map<String, dynamic> data) {
  return jsonEncode(data);
}

String companiesToJson(companyDetails) {
  return toJson(companyDetails);
}

String facilitiesToJson(facilityValues) {
  return toJson(facilityValues);
}

String branchesToJson(List<String> branches, String commonFee) {
  Map<String, String> branchesMap = {};
  for (String branch in branches) {
    branchesMap[branch] = commonFee;
  }
  return toJson({'branches': branchesMap});
}

Widget detailsDropdownNew(
    String hint,
    List<String> list,
    double mobileWidth,
    Function(String) onChanged,
    String title,
    String description,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: mobileWidth - 40,
          child: CustomDropdown<String>(
            closedFillColor: Colors.transparent,
            closedBorder:
                Border.all(color: const Color.fromARGB(255, 138, 136, 136)),
            hintText: hint,
            items: list,
            initialItem: list[0],
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
      ],
    ),
  );
}

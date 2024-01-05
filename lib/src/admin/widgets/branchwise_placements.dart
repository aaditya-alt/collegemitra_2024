import 'dart:convert';

import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: list
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: list[0],
              onChanged: (String? value) {
                onChanged(value!);
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

import 'dart:math';

import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'package:get/get.dart';

class ExcelCollegePredictor extends GetxController {
  static ExcelCollegePredictor get instance => Get.find();

  Future<List<CollegeData>> processExcelData(String state, String category,
      String gender, int userRank, String counselling, String exam) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    List<CollegeData> filteredData = [];

    for (var table in excel.tables.keys) {
      CollegeData? currentCollege;
      BranchData? currentBranch;

      for (var row in excel.tables[table]!.rows) {
        bool isIIT = row[7]!.value.toString().contains("IIT");

        if (exam == "JEE Main" && isIIT) {
          // Skip non-IIT colleges for JEE Main
          continue;
        }

        // Check if the exam is JEE Advanced and the college type is IIT
        if (exam == "JEE Advanced" && !isIIT) {
          // Skip non-IIT colleges for JEE Advanced
          continue;
        }
        if (row[8]!.value.toString() == state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "OS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            if (currentCollege == null ||
                currentCollege.collegeName != row[0]!.value.toString()) {
              currentCollege = CollegeData(
                collegeName: row[0]!.value.toString(),
                collegeType: row[7]!.value.toString(),
                branches: [],
              );
              filteredData.add(currentCollege);
            }

            if (currentBranch == null ||
                currentBranch.branchName != row[1]!.value.toString()) {
              currentBranch = BranchData(
                branchName: row[1]!.value.toString(),
                rounds: [],
              );
              currentCollege.branches.add(currentBranch);
            }

            currentBranch.rounds.add(RoundData(
              roundName: row[9]!.value.toString(),
              openingRank: int.parse(row[5]!.value.toString()),
              closingRank: int.parse(row[6]!.value.toString()),
              rankDifference: int.parse(row[6]!.value.toString()) - userRank,
            ));
          }
        } else if (row[8]!.value.toString() != state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "HS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            if (currentCollege == null ||
                currentCollege.collegeName != row[0]!.value.toString()) {
              currentCollege = CollegeData(
                collegeName: row[0]!.value.toString(),
                collegeType: row[7]!.value.toString(),
                branches: [],
              );
              filteredData.add(currentCollege);
            }

            if (currentBranch == null ||
                currentBranch.branchName != row[1]!.value.toString()) {
              currentBranch = BranchData(
                branchName: row[1]!.value.toString(),
                rounds: [],
              );
              currentCollege.branches.add(currentBranch);
            }

            currentBranch.rounds.add(RoundData(
              roundName: row[9]!.value.toString(),
              openingRank: int.parse(row[5]!.value.toString()),
              closingRank: int.parse(row[6]!.value.toString()),
              rankDifference: int.parse(row[6]!.value.toString()) - userRank,
            ));
          }
        }
      }
    }

    return filteredData;
  }

  Future<int> getNoOfBranches(String collegeName) async {
    int branches = 0;
    ByteData data = await rootBundle.load('assets/cutoff_files/round_6.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        var cellValue = row[0]?.value;

        if (cellValue is String && cellValue == collegeName) {
          // Check if the first column has the desired collegeName
          var branchName = row[1]?.value;
          if (branchName is String) {
            branches = branchName.length;
          }
        }
      }
    }

    return branches;
  }
}

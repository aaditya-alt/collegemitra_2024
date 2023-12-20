import 'dart:math';

import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'package:get/get.dart';

class ExcelCollegePredictor extends GetxController {
  static ExcelCollegePredictor get instance => Get.find();

//College predictor
  Future<List<CollegeData>> processExcelData(String state, String category,
      String gender, int userRank, String counselling, String exam) async {
    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    Map<String, CollegeData> filteredColleges = {};

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        bool isIIT = row[7]!.value.toString() == "IIT";
        bool isGo = row[2]!.value.toString().contains("GO");
        bool isJK = row[2]!.value.toString().contains("JK");

        if (exam == "JEE Main" && isIIT) {
          // Skip non-IIT colleges for JEE Main
          continue;
        }

        if (state != "Goa" && isGo) {
          continue;
        }
        if (state != "Jammu & Kashmir" && isJK) {
          continue;
        }

        // Check if the exam is JEE Advanced and the college type is IIT
        if (exam == "JEE Advanced" && !isIIT) {
          // Skip non-IIT colleges for JEE Advanced
          continue;
        }

        if (row[8]?.value.toString() == state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "OS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            String collegeName = row[0]!.value.toString();

            if (filteredColleges.containsKey(collegeName)) {
              // College already exists, update the data
              CollegeData currentCollege = filteredColleges[collegeName]!;
              updateCollegeData(currentCollege, row, userRank);
            } else {
              // College doesn't exist, create a new entry
              CollegeData newCollege = createCollegeData(row, userRank);
              filteredColleges[collegeName] = newCollege;
            }
          }
        } else if (row[8]?.value.toString() != state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "HS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            String collegeName = row[0]!.value.toString();

            if (filteredColleges.containsKey(collegeName)) {
              // College already exists, update the data
              CollegeData currentCollege = filteredColleges[collegeName]!;
              updateCollegeData(currentCollege, row, userRank);
            } else {
              // College doesn't exist, create a new entry
              CollegeData newCollege = createCollegeData(row, userRank);
              filteredColleges[collegeName] = newCollege;
            }
          }
        }
      }
    }

    return filteredColleges.values.toList();
  }

  void updateCollegeData(CollegeData college, List<dynamic> row, int userRank) {
    BranchData currentBranch;
    // Check if the branch already exists
    if (college.branches
        .any((branch) => branch.branchName == row[1]!.value.toString())) {
      currentBranch = college.branches.firstWhere(
          (branch) => branch.branchName == row[1]!.value.toString());
    } else {
      // Branch doesn't exist, create a new branch
      currentBranch = BranchData(
        branchName: row[1]!.value.toString(),
        rounds: [],
      );
      college.totalBranchLength++;
      college.branches.add(currentBranch);
    }

    currentBranch.rounds.add(RoundData(
      roundName: row[9]!.value.toString(),
      openingRank: int.parse(row[5]!.value.toString()),
      closingRank: int.parse(row[6]!.value.toString()),
      rankDifference: int.parse(row[6]!.value.toString()) - userRank,
    ));
  }

  CollegeData createCollegeData(List<dynamic> row, int userRank) {
    CollegeData newCollege = CollegeData(
      collegeName: row[0]!.value.toString(),
      collegeType: row[7]!.value.toString(),
      collegeState: row[8]!.value.toString(),
      totalBranchLength: 1,
      branches: [
        BranchData(
          branchName: row[1]!.value.toString(),
          rounds: [
            RoundData(
              roundName: row[9]!.value.toString(),
              openingRank: int.parse(row[5]!.value.toString()),
              closingRank: int.parse(row[6]!.value.toString()),
              rankDifference: int.parse(row[6]!.value.toString()) - userRank,
            ),
          ],
        ),
      ],
    );

    return newCollege;
  }

  //Get all branches dynamically
  Future<List<String>> getBranchesFromCounselling(String counselling) async {
    Set<String> branches = {};
    List<String> branchesData = [];

    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        branches.add(row[1]?.value.toString() ??
            ''); // Assuming row[1] contains branch information
      }
    }

    branchesData = branches.toList();
    branchesData.remove(branchesData.first);

    // Now, 'branches' Set contains all unique branches for the specified counselling
    return branchesData;
  }

//Data to show for branch predictor
  Future<List<CollegeData>> getCollegesForBranches(
      String state,
      String category,
      String gender,
      int userRank,
      String counselling,
      String exam,
      List<String> selectedBranches) async {
    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    Map<String, CollegeData> filteredColleges = {};

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        bool isIIT = row[7]!.value.toString() == "IIT";
        bool isGo = row[2]!.value.toString().contains("GO");
        bool isJK = row[2]!.value.toString().contains("JK");
        bool isBranches = selectedBranches.contains(row[1]!.value.toString());

        if (exam == "JEE Main" && isIIT) {
          // Skip non-IIT colleges for JEE Main
          continue;
        }

        if (!isBranches) {
          continue;
        }

        if (state != "Goa" && isGo) {
          continue;
        }
        if (state != "Jammu & Kashmir" && isJK) {
          continue;
        }

        // Check if the exam is JEE Advanced and the college type is IIT
        if (exam == "JEE Advanced" && !isIIT) {
          // Skip non-IIT colleges for JEE Advanced
          continue;
        }

        if (row[8]?.value.toString() == state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "OS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            String collegeName = row[0]!.value.toString();

            if (filteredColleges.containsKey(collegeName)) {
              // College already exists, update the data
              CollegeData currentCollege = filteredColleges[collegeName]!;
              updateCollegeData(currentCollege, row, userRank);
            } else {
              // College doesn't exist, create a new entry
              CollegeData newCollege = createCollegeData(row, userRank);
              filteredColleges[collegeName] = newCollege;
            }
          }
        } else if (row[8]?.value.toString() != state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender &&
              row[2]!.value.toString() != "HS" &&
              int.parse(row[6]!.value.toString()) > userRank) {
            String collegeName = row[0]!.value.toString();

            if (filteredColleges.containsKey(collegeName)) {
              // College already exists, update the data
              CollegeData currentCollege = filteredColleges[collegeName]!;
              updateCollegeData(currentCollege, row, userRank);
            } else {
              // College doesn't exist, create a new entry
              CollegeData newCollege = createCollegeData(row, userRank);
              filteredColleges[collegeName] = newCollege;
            }
          }
        }
      }
    }

    return filteredColleges.values.toList();
  }

  //Get all colleges dynamically
  Future<List<String>> getCollegesFromCounselling(String counselling) async {
    Set<String> colleges = {};
    List<String> collegessData = [];

    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        colleges.add(row[0]?.value.toString() ??
            ''); // Assuming row[1] contains branch information
      }
    }

    collegessData = colleges.toList();
    collegessData.remove(collegessData.first);

    // Now, 'branches' Set contains all unique branches for the specified counselling
    return collegessData;
  }

  //Get all branches dynamically
  Future<List<String>> getBranchesFromColleges(
      String college, String counselling) async {
    Set<String> branches = {};
    List<String> branchesData = [];

    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]?.value.toString() == college) {
          branches.add(row[1]?.value.toString() ?? '');
        }
      }
    }

    branchesData = branches.toList();
    branchesData.remove(branchesData.first);

    // Now, 'branches' Set contains all unique branches for the specified counselling
    return branchesData;
  }

  Future<List<Cutoff>> getCutoffDataForCollege(
      String counselling, String collegeName, String category) async {
    Set<String> uniqueBranches = {}; // Initialize the set

    ByteData data =
        await rootBundle.load('assets/cutoff_files/${counselling}_2023.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    List<Cutoff> cutoffDetails = [];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        bool isGo = row[2]!.value.toString().contains("GO");
        bool isJK = row[2]!.value.toString().contains("JK");

        if (isGo || isJK) {
          continue;
        }

        if (row[0]?.value.toString() == collegeName &&
            row[3]?.value.toString() == category) {
          String branchName = row[1]!.value.toString();

          // Check if the branch is unique, then add it to the set and create a Cutoff object
          if (uniqueBranches.add(branchName)) {
            cutoffDetails.add(
              Cutoff(
                branchName: branchName,
                closingRank: row[6]!.value.toString(),
              ),
            );
          }
        }
      }
    }

    return cutoffDetails;
  }
}

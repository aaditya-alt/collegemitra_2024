import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'package:get/get.dart';

class ExcelCollegePredictor extends GetxController {
  static ExcelCollegePredictor get instance => Get.find();

  Future<List<CollegeData>> processExcelData(
      String state, String category, String gender, int userRank) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    List<CollegeData> filteredData = [];

    for (var table in excel.tables.keys) {
      CollegeData? currentCollege;
      BranchData? currentBranch;

      for (var row in excel.tables[table]!.rows) {
        if (row[8]!.value.toString() == state) {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender) {
            if (currentCollege == null ||
                currentCollege.collegeName != row[0]!.value.toString()) {
              currentCollege = CollegeData(
                collegeName: row[0]!.value.toString(),
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
              rankDifference: int.parse(row[6]!.value.toString()) -
                  int.parse(row[5]!.value.toString()),
            ));
          }
        } else if (row[2]!.value.toString() == 'OS' ||
            row[2]!.value.toString() == 'AI') {
          if (row[3]!.value.toString() == category &&
              row[4]!.value.toString() == gender) {
            if (currentCollege == null ||
                currentCollege.collegeName != row[0]!.value.toString()) {
              currentCollege = CollegeData(
                collegeName: row[0]!.value.toString(),
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
              rankDifference: int.parse(row[6]!.value.toString()) -
                  int.parse(row[5]!.value.toString()),
            ));
          }
        }
      }
    }

    return filteredData;
  }

  getStateDataToPopulate(String counselling) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    List<DropdownMenuEntry<dynamic>> domicileList = [];

    Set<String> statedata = new Set();
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        statedata.add(row[8]!.value.toString());
      }
    }
    statedata.remove("state");

    for (var state in statedata) {
      domicileList.add(DropdownMenuEntry(value: state, label: state));
    }
    return domicileList;
  }

  //Get category data to populate

  getCategoryDataToPopulate(String counselling, String state) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    List<DropdownMenuEntry<dynamic>> domicileList = [];

    Set<String> statedata = new Set();

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[8]!.value.toString() == state) {
          statedata.add(row[3]!.value.toString());
        } else if (row[8]!.value.toString() != state) {
          statedata.add(row[3]!.value.toString());
        }
      }
    }
    statedata.remove("category");

    for (var state in statedata) {
      domicileList.add(DropdownMenuEntry(value: state, label: state));
    }
    return domicileList;
  }

  List<String> uniqueStates = []; // List to store unique states

  Future<List<String>> getUniqueStates() async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    uniqueStates
        .clear(); // Clear the list in case this method is called multiple times

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        final state = row[8]?.value?.toString() ?? "";
        if (!uniqueStates.contains(state)) {
          uniqueStates.add(state);
        }
      }
    }
    return uniqueStates;
  }

  List<String> uniqueCategories = [];

  Future<List<String>> getUniqueCategoriesForState(String selectedState) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    uniqueCategories.clear();

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        final state = row[8]?.value?.toString() ?? "";
        final category = row[3]?.value?.toString() ?? "";

        if (state == selectedState && !uniqueCategories.contains(category)) {
          uniqueCategories.add(category);
        }
      }
    }
    return uniqueCategories;
  }

  List<String> uniqueSubCategories = [];

  Future<List<String>> getUniqueSubCategoriesForState(
      String selectedState, String selectedCategory) async {
    ByteData data = await rootBundle.load('assets/cutoff_files/test.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    uniqueSubCategories.clear();

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        final state = row[8]?.value?.toString() ?? "";
        final category = row[3]?.value?.toString() ?? "";
        final subCategory = row[4]?.value?.toString() ?? "";

        if (state == selectedState &&
            category == selectedCategory &&
            !uniqueSubCategories.contains(subCategory)) {
          uniqueSubCategories.add(subCategory);
        }
      }
    }
    return uniqueSubCategories;
  }
}

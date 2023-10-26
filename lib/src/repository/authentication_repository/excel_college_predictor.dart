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

  Future<List> getStateDataToPopulate(String counselling) async {
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
}

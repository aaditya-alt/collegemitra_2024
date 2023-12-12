import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';

class BranchwisePlacementsModal extends StatefulWidget {
  final List<String> branches;
  final Function(Map<String, Map<String, String>>) onSave;

  const BranchwisePlacementsModal({
    Key? key,
    required this.branches,
    required this.onSave,
  }) : super(key: key);

  @override
  _BranchwisePlacementsModalState createState() =>
      _BranchwisePlacementsModalState();
}

class _BranchwisePlacementsModalState extends State<BranchwisePlacementsModal> {
  Map<String, Map<String, String>> branchDetails = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Enter Branchwise Placements",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.branches.length,
              itemBuilder: (context, index) {
                String branch = widget.branches[index];
                return BranchDetailsCard(
                  branch: branch,
                  onDetailsChanged: (highestPackage, averagePackage,
                      percentagePlacement, seats) {
                    setState(() {
                      Map<String, String> details = {
                        'highestPackage': highestPackage,
                        'averagePackage': averagePackage,
                        'percentagePlacement': percentagePlacement,
                        'seats': seats,
                      };
                      branchDetails[branch] = details;
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSave(branchDetails);
              Navigator.pop(context); // Close the modal bottom sheet
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

class BranchDetailsCard extends StatefulWidget {
  final String branch;
  final Function(String, String, String, String) onDetailsChanged;

  const BranchDetailsCard({
    Key? key,
    required this.branch,
    required this.onDetailsChanged,
  }) : super(key: key);

  @override
  State<BranchDetailsCard> createState() => _BranchDetailsCardState();
}

class _BranchDetailsCardState extends State<BranchDetailsCard> {
  String highestPackage = "";
  String averagePackage = "";
  String placementPercentage = "";
  String seats = "";
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.branch,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Highest Package"),
              onChanged: (value) {
                setState(() {
                  highestPackage = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Average Package"),
              onChanged: (value) {
                setState(() {
                  averagePackage = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Percentage Placement",
              ),
              onChanged: (value) {
                setState(() {
                  placementPercentage = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Seats"),
              onChanged: (value) {
                setState(() {
                  seats = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(color),
                  elevation: const MaterialStatePropertyAll(2)),
              onPressed: () {
                widget.onDetailsChanged(
                  highestPackage,
                  averagePackage,
                  placementPercentage,
                  seats,
                );

                setState(() {
                  color = Colors.green;
                });
              },
              child: const Text("Save Details"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>> getCollegesList(String counselling) async {
  List<String> colleges = [];
  final excel = ExcelCollegePredictor();

  final data = await excel.getCollegesFromCounselling(counselling);
  colleges.addAll(data);

  return colleges;
}

Future<List<String>> getBranchesList(String college, String counselling) async {
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

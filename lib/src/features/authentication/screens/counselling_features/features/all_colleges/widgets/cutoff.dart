import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CutoffPage extends StatefulWidget {
  final String collegeName;

  const CutoffPage({super.key, required this.collegeName});

  @override
  State<CutoffPage> createState() => _CutoffPageState();
}

class _CutoffPageState extends State<CutoffPage> {
  String selectedCategory = "EWS";
  String selectedRound = "JOSAA Round 6";
  bool isLoading = false;

  List<String> categories = [
    'EWS',
    'OPEN',
    'OBC-NCL',
    'SC',
    'ST',
    'OPEN (PwD)',
    'EWS (PwD)',
    'OBC-NCL (PwD)',
    'SC (PwD)',
    'ST (PwD)'
  ];

  List<String> rounds = ["JOSAA Round 6", "CSAB Round 2"];
  List<Cutoff> cutoffData = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildDropdown("Select Round", rounds, (value) {
              setState(() {
                selectedRound = value.toString();
              });
            }),
            const SizedBox(height: 20),
            buildDropdown("Select Category", categories, (value) {
              setState(() {
                selectedCategory = value.toString();
              });
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 121, 3)),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(const Duration(milliseconds: 500));
                    cutoffData = await getCutoffData(
                        widget.collegeName, selectedCategory, selectedRound);

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text("Get Cutoff Data",
                          style: Theme.of(context).textTheme.titleSmall),
                ),
              ),
            ),
            const SizedBox(height: 20),
            cutoffData.isEmpty
                ? const SizedBox(height: 0)
                : CutoffTable(cutoffData: cutoffData),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
      String label, List<String> items, void Function(String?) onChanged) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepOrange, width: 2),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: label == "Select Round" ? selectedRound : selectedCategory,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: const SizedBox(),
        onChanged: onChanged,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class CutoffTable extends StatelessWidget {
  final List<Cutoff> cutoffData;

  const CutoffTable({Key? key, required this.cutoffData}) : super(key: key);

  TableRow buildTableRow(String branch, String cutoff) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              branch,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              cutoff,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(186, 255, 182, 115),
      ),
      padding: const EdgeInsets.all(7),
      child: Table(
        border: TableBorder.all(
          color: Colors.white,
          width: 2,
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          const TableRow(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Branches',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Closing Rank',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 16),
                ),
              ),
            ),
          ]),
          for (var cutoff in cutoffData)
            buildTableRow(cutoff.branchName, cutoff.closingRank),
        ],
      ),
    );
  }
}

Future<List<Cutoff>> getCutoffData(
  String collegeName,
  String category,
  String roundName,
) async {
  String counselling = "JOSAA";
  if (roundName == "JOSAA Round 6") {
    counselling = "JOSAA";
  } else {
    counselling = "CSAB";
  }
  List<Cutoff> cutoffData = [];
  try {
    final excel = Get.put(ExcelCollegePredictor());
    cutoffData =
        await excel.getCutoffDataForCollege(counselling, collegeName, category);
    return cutoffData;
  } catch (e) {
    Get.snackbar("Error", "Some Error Occurred!");
    return cutoffData;
    // Return an empty container or another widget to indicate error
  }
}

import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:flutter/material.dart';

class Branchestab extends StatelessWidget {
  final List<CollegeDetails> collegeDetails;
  const Branchestab({super.key, required this.collegeDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            BranchWisefees(branches: collegeDetails[0].branchesFees),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BranchWisefees extends StatelessWidget {
  final List<Branch> branches;

  const BranchWisefees({Key? key, required this.branches}) : super(key: key);

  TableRow buildTableRow(String branch, String fees) {
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
              "₹ $fees",
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
                  'Yearly Fees',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 16),
                ),
              ),
            ),
          ]),
          for (var branch in branches)
            buildTableRow(branch.branchName, branch.fee),
        ],
      ),
    );
  }
}

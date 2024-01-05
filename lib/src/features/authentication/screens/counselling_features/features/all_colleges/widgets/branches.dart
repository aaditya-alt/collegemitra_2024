import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
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
              fees,
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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey,
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

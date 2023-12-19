import 'package:flutter/material.dart';

class CutoffPage extends StatefulWidget {
  const CutoffPage({super.key});

  @override
  State<CutoffPage> createState() => _CutoffPageState();
}

class _CutoffPageState extends State<CutoffPage> {
  int cutoff = 0;
  String? selectedCategory;
  String? selectedRound;

  List<String> categories = ["Category 1", "Category 2", "Category 3"];
  List<String> rounds = ["Round 1", "Round 2", "Round 3"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildDropdown("Select Round", rounds, (String? value) {
              setState(() {
                selectedRound = value;
              });
            }),
            SizedBox(height: 20),
            buildDropdown("Select Category", categories, (String? value) {
              setState(() {
                selectedCategory = value;
              });
            }),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
              ),
              onPressed: () {
                cutoff = 1;
                // Handle submit button press
                print(
                    "Selected Round: $selectedRound, Selected Category: $selectedCategory");
              },
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            CutoffTable(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
      String label, List<String> items, void Function(String?) onChanged) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepOrange, width: 2),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: label == "Select Round" ? selectedRound : selectedCategory,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: SizedBox(),
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
  const CutoffTable({super.key});

  TableRow buildTableRow(String branch, String cutoff) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              branch,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              cutoff,
              style: TextStyle(fontSize: 14),
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
        color: Color.fromARGB(186, 255, 182, 115),
      ),
      padding: EdgeInsets.all(7),
      child: Table(
        border: TableBorder.all(
          color: Colors.white,
          width: 2,
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Cutoff',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 16),
                ),
              ),
            ),
          ]),
          buildTableRow('Computer Science Engineering', '1534'),
          buildTableRow('Bio-Technology', '29829'),
          buildTableRow('Chemical Engineering', '20029'),
          buildTableRow('Civil Engineering', '25762'),
          buildTableRow('Electrical and Electronics Engineering', '9370'),
          buildTableRow('Electronics and Communication Engineering', '6119'),
          buildTableRow('Metallurgical and Material Engineering', '26725'),
          buildTableRow(
              'Physics (5 Years, Integrated Master of Science)', '26534'),
          buildTableRow(
              'Mathematics (5 years, Integrated Master of Science)', '25256'),
          buildTableRow(
              "Chemistry (5 Years, Integrated Master of Science)", "36579"),
        ],
      ),
    );
  }
}

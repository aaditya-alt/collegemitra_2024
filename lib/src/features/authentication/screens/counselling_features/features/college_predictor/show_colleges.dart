import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_branches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowColleges extends StatefulWidget {
  final List<dynamic> userDetails;
  final List<CollegeData> collegesToShow;
  final String counsellingName;

  const ShowColleges({
    Key? key,
    required this.collegesToShow,
    required this.counsellingName,
    required this.userDetails,
  });

  @override
  State<ShowColleges> createState() => _ShowCollegesState();
}

class _ShowCollegesState extends State<ShowColleges> {
  bool isLoading = false;
  List<CollegeData> filteredColleges = [];
  List<String> selectedTypeOptions = [];
  List<String> selectedBranchOptions = [];
  List<String> selectedCollegeOptions = [];

  @override
  void initState() {
    super.initState();
    filteredColleges = List.from(widget.collegesToShow);
  }

  @override
  Widget build(BuildContext context) {
    List<String> userDetailsName = [
      "Counselling",
      "Domicile",
      "Category",
      "Sub Category",
      "JEE Rank"
    ];

    List<String> collegeType = [];
    if (widget.counsellingName == "JOSAA") {
      collegeType.add("All");
      collegeType.add("IIT");
      collegeType.add("NIT");
      collegeType.add("IIIT");
      collegeType.add("GFTI");
    }

    Map<String, int> collegeTypeCounts = {
      "All": widget.collegesToShow.length,
      "IIT": 0,
      "NIT": 0,
      "IIIT": 0,
      "GFTI": 0,
    };

    void filterColleges(String query) {
      setState(() {
        isLoading = true;
        filteredColleges = widget.collegesToShow
            .where((college) =>
                college.collegeName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        isLoading = false;
      });
    }

    for (var college in widget.collegesToShow) {
      String collegesType = college.collegeType;

      if (collegeTypeCounts.containsKey(collegesType)) {
        collegeTypeCounts[collegesType] = collegeTypeCounts[collegesType]! + 1;
      }
    }

    Set<String> uniqueCollegeNames = {};
    Set<String> uniqueCollegeTypes = {};
    Set<String> uniqueBranchNames = {};

// Populate sets with unique values
    for (CollegeData college in widget.collegesToShow) {
      uniqueCollegeNames.add(college.collegeName);
      uniqueCollegeTypes.add(college.collegeType);

      for (BranchData branch in college.branches) {
        uniqueBranchNames.add(branch.branchName);
      }
    }

    List<String> collegeNames = uniqueCollegeNames.toList();
    List<String> collegeTypes = uniqueCollegeTypes.toList();
    List<String> branchNames = uniqueBranchNames.toList();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.counsellingName} Colleges",
        ),
        centerTitle: true,
        backgroundColor: tPrimaryColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 8,
                  bottom: 12,
                ),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      onChanged: filterColleges,
                      decoration: InputDecoration(
                        hintText: "Search Colleges...",
                        suffixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              isDismissible: true,
                              enableDrag: true,
                              elevation: 3,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.85, // Adjust the height based on your preference
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Filter Options',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        DefaultTabController(
                                          length: 3,
                                          child: Column(
                                            children: [
                                              const TabBar(
                                                tabs: [
                                                  Tab(text: 'Type'),
                                                  Tab(text: 'Branches'),
                                                  Tab(text: 'Colleges'),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height / 1.7,
                                                // Adjust the height based on your content
                                                child: TabBarView(
                                                  children: [
                                                    // Type Tab
                                                    CheckboxOptions(
                                                      options: collegeTypes,
                                                      selectedOptions:
                                                          selectedTypeOptions,
                                                    ),
                                                    // Branches Tab
                                                    CheckboxOptions(
                                                      options: branchNames,
                                                      selectedOptions:
                                                          selectedBranchOptions,
                                                    ),
                                                    // Colleges Tab
                                                    CheckboxOptions(
                                                      options: collegeNames,
                                                      selectedOptions:
                                                          selectedCollegeOptions,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the bottom sheet
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // Implement the logic to apply the selected filters
                                                  // You can use selectedTypeOptions, selectedBranchOptions, and selectedCollegeOptions
                                                  // for applying the filters in your code.
                                                  // Close the bottom sheet

                                                  setState(() {
                                                    filteredColleges = widget
                                                        .collegesToShow
                                                        .where((college) {
                                                      // Check if the college type is selected
                                                      bool isTypeSelected =
                                                          selectedTypeOptions
                                                                  .isEmpty ||
                                                              selectedTypeOptions
                                                                  .contains(college
                                                                      .collegeType);

                                                      // Check if any branch is selected
                                                      bool areBranchesSelected =
                                                          selectedBranchOptions
                                                                  .isEmpty ||
                                                              college.branches.any((branch) =>
                                                                  selectedBranchOptions
                                                                      .contains(
                                                                          branch
                                                                              .branchName));

                                                      // Check if the college is selected
                                                      bool isCollegeSelected =
                                                          selectedCollegeOptions
                                                                  .isEmpty ||
                                                              selectedCollegeOptions
                                                                  .contains(college
                                                                      .collegeName);

                                                      return isTypeSelected &&
                                                          areBranchesSelected &&
                                                          isCollegeSelected;
                                                    }).toList();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Apply'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.filter_alt_rounded),
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: tPrimaryColor.shade300,
                    height: 57,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width: 120,
                              margin: const EdgeInsets.all(4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userDetailsName[index],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 117, 117, 117),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    widget.userDetails[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "|\n|\n|",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width - 45),
                    child: Container(
                      width: 45,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: tPrimaryColor,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          Get.back();
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                color: const Color.fromARGB(255, 204, 204, 204),
                height: 42,
                child: ListView.builder(
                  itemCount: collegeType.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          margin: const EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "${collegeType[index]} Colleges\n (${collegeTypeCounts[collegeType[index]]})",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "|\n|\n|",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredColleges.length,
                  itemBuilder: (context, index) {
                    var college = filteredColleges[index];
                    final isEvenIndex = index.isEven;

                    return ListTile(
                      tileColor:
                          isEvenIndex ? Colors.grey.shade200 : Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: FutureBuilder(
                              future: getCollegeChance(college),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    print("Error : ${snapshot.error}");
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Center(child: snapshot.data);
                                  }
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  college.collegeName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${college.branches.length} Branches",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              GestureDetector(
                                child: const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: tPrimaryColor,
                                  size: 30,
                                ),
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Get.to(() => ShowBranches(
                                        branchesToShow: college.branches,
                                        counsellingName: widget.counsellingName,
                                        userDetails: widget.userDetails,
                                        collegeName: college.collegeName,
                                      ));
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: size.height / 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _controller = Get.put(CollegePredictorController());

Future<Widget> getCollegeChance(CollegeData college) async {
  final realCount =
      await _controller.getBranchesNumber(college.collegeName.toString());
  int havingCount = college.branches.length;

  double chance = havingCount / int.parse(realCount.toString());

  if (chance >= 0.6) {
    return Image.asset(
        'assets/gif/happy.gif'); // Star emoji for great chance (yellow or gold star)
  } else if (chance >= 0.3 && chance < 0.6) {
    return Image.asset(
        'assets/gif/neutral.gif'); // Neutral face for fair chance (neutral face in yellow or orange tone)
  } else {
    return Image.asset(
        'assets/gif/sad.gif'); // Crying face for slim chance (crying face in yellow or orange tone)
  }
}

class CheckboxOptions extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;

  CheckboxOptions({required this.options, required this.selectedOptions});

  @override
  _CheckboxOptionsState createState() => _CheckboxOptionsState();
}

class _CheckboxOptionsState extends State<CheckboxOptions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(widget.options[index]),
          value: widget.selectedOptions.contains(widget.options[index]),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                if (value) {
                  widget.selectedOptions.add(widget.options[index]);
                } else {
                  widget.selectedOptions.remove(widget.options[index]);
                }
              }
            });
          },
        );
      },
    );
  }
}

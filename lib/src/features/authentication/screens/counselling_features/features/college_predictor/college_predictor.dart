import 'dart:ffi';

import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CollegePredictor extends StatefulWidget {
  final String counselling_name;

  // ignore: non_constant_identifier_names
  const CollegePredictor({super.key, required this.counselling_name});

  @override
  State<CollegePredictor> createState() => _CollegePredictorState();
}

class _CollegePredictorState extends State<CollegePredictor> {
  final ExcelCollegePredictor _collegePredictor =
      ExcelCollegePredictor.instance;
  String selectedState = "Select State";
  String selectedCategory = "Select Category";
  String selectedSubCategory = "SubCategory";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(CollegePredictorController());
    final size = MediaQuery.of(context).size.width;

    var counselling;
    if (widget.counselling_name == "GGSIPU Delhi") {
      counselling = "GGSIPU";
    } else if (widget.counselling_name == "JAC Delhi") {
      counselling = "JACD";
    } else {
      counselling = widget.counselling_name;
    }

    setState(() {
      isLoading = true;
    });
    List selectedItems = [
      counselling,
      selectedState,
      selectedCategory,
      selectedSubCategory,
      controller.userRank.text.trim().toString(),
    ];
    setState(() {
      isLoading = false;
    });

    List<String> userDetailsName = [
      "Counselling",
      "Domicile",
      "Category",
      "Sub Category",
      "JEE Mains Rank"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          counselling + " College Predictor",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const MyCarouselSlider(),
                const SizedBox(height: 20),
                Container(
                  color: tPrimaryColor.shade100,
                  height: 55,
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
                                  selectedItems[index],
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
                            style: TextStyle(color: tPrimaryColor),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Asking user to fill domicile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: FutureBuilder<List<String>>(
                            future: _collegePredictor
                                .getUniqueStates(), // Your asynchronous function
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While the future is still loading, show a loading indicator.
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // If there's an error, display an error message.
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                // If there's no data, you can show a message indicating that there are no states.
                                return const Text('No states available');
                              } else {
                                // If the data is available, create the dropdown.
                                return DropdownButton<String>(
                                    alignment: Alignment.centerLeft,
                                    value: snapshot.data!.first,
                                    items: snapshot.data!.map((state) {
                                      return DropdownMenuItem<String>(
                                        value: state,
                                        child: Text(
                                          state,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                tPrimaryColor, // Customize text color
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      selectedState = value!;
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                              }
                            },
                          ),
                        ),
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 28,
                          color: tPrimaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    //Asking user to fill category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: FutureBuilder<List<String>>(
                            future:
                                _collegePredictor.getUniqueCategoriesForState(
                                    selectedState), // Your asynchronous function
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While the future is still loading, show a loading indicator.
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // If there's an error, display an error message.
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                // If there's no data, you can show a message indicating that there are no states.
                                return const Text('No Category available');
                              } else {
                                // If the data is available, create the dropdown.
                                return DropdownButton<String>(
                                    value: snapshot.data!.first,
                                    items: snapshot.data!.map((category) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerLeft,
                                        value: category,
                                        child: Text(
                                          category,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                tPrimaryColor, // Customize text color
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      selectedCategory = value!;

                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                              }
                            },
                          ),
                        ),
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 28,
                          color: tPrimaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    //Asking user to fill subCategory
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: FutureBuilder<List<String>>(
                            future: _collegePredictor
                                .getUniqueSubCategoriesForState(selectedState,
                                    selectedCategory), // Your asynchronous function
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While the future is still loading, show a loading indicator.
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // If there's an error, display an error message.
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                // If there's no data, you can show a message indicating that there are no states.
                                return const Text('No Category available');
                              } else {
                                // If the data is available, create the dropdown.
                                return DropdownButton<String>(
                                    value: snapshot.data!.first,
                                    items: snapshot.data!.map((subCategory) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerLeft,
                                        value: subCategory,
                                        child: Text(
                                          subCategory,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                tPrimaryColor, // Customize text color
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      selectedSubCategory = value!;

                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                              }
                            },
                          ),
                        ),
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 28,
                          color: tPrimaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    //Asking user to fill their rank
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: TextFormField(
                          controller: controller.userRank,
                          cursorColor: tPrimaryColor,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'JEE Mains CRL Rank',
                            labelStyle: TextStyle(
                                color: tPrimaryColor,
                                fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: tPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 22, top: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(tPrimaryColor),
                            elevation: MaterialStateProperty.all(5),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller.setLoading(true);
                                  if (selectedCategory == "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text(
                                              "Please Select the Category"),
                                        );
                                      },
                                    ).then((_) {
                                      controller.setLoading(false);
                                    });
                                  } else if (selectedSubCategory == "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text(
                                              "Please Select the Sub Category"),
                                        );
                                      },
                                    ).then((_) {
                                      controller.setLoading(false);
                                    });
                                  } else if (selectedState == "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text(
                                              "Please Select the Domicile"),
                                        );
                                      },
                                    ).then((_) {
                                      controller.setLoading(false);
                                    });
                                  } else if (controller.userRank.text.trim() ==
                                      "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text("Please Enter the Rank"),
                                        );
                                      },
                                    ).then((_) {
                                      controller.setLoading(false);
                                    });
                                  } else {
                                    await controller.predictCollegesUsingExcel(
                                      widget.counselling_name,
                                      selectedCategory,
                                      selectedSubCategory,
                                      int.parse(
                                          controller.userRank.text.trim()),
                                      selectedState,
                                    );
                                    controller.setLoading(false);
                                  }
                                },
                          icon: Obx(() {
                            if (controller.isLoading.value) {
                              return const SizedBox(
                                width:
                                    21.0, // Adjust the width to make it smaller
                                height:
                                    21.0, // Adjust the height to make it smaller
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth:
                                      4.0, // Adjust the strokeWidth to control the size
                                ),
                              );
                            } else {
                              return const Icon(Icons.school_rounded);
                            }
                          }),
                          label: Text(
                            controller.isLoading.value
                                ? 'Getting Colleges'
                                : 'Get Colleges',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            if (isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black
                    .withOpacity(0.3), // Semi-transparent background
                child: const Center(
                  child: CircularProgressIndicator(), // Your beautiful loader
                ),
              ),
          ],
        ),
      ),
    );
  }
}

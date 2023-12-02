import 'dart:developer';
import 'dart:ui';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_colleges.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/welcome/animated_button.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class BranchPredictor extends StatefulWidget {
  final String counselling_name;

  // ignore: non_constant_identifier_names
  const BranchPredictor({super.key, required this.counselling_name});

  @override
  State<BranchPredictor> createState() => _BranchPredictorState();
}

class _BranchPredictorState extends State<BranchPredictor> {
  final _controller = Get.put(CollegePredictorController());
  bool isLoading = false;

  List<String> branches = [];

  @override
  void initState() {
    _loadBranches();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadBranches() async {
    try {
      final data =
          await _controller.getBranchesUsingExcel(widget.counselling_name);
      setState(() {
        branches = data;
      });
    } catch (error) {
      print("Error loading branches: $error");
    }
  }

  String selectedState = "Punjab";
  String selectedCategory = "EWS";
  String selectedSubCategory = "Gender-Neutral";
  String selectedExam = "JEE Main";
  String selectedCounselling = "JOSAA";
  String rankToEnter = "Category Rank";
  List<String> selectedBranches = [];

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size.width;
    var counselling = "";
    if (widget.counselling_name == "GGSIPU Delhi") {
      counselling = "GGSIPU";
    } else if (widget.counselling_name == "JAC Delhi") {
      counselling = "JACD";
    } else {
      counselling = widget.counselling_name;
    }

    List<String> states = [
      "Punjab",
      "Rajasthan",
      "Madhya Pradesh",
      "Uttar Pradesh",
      "Tripura",
      "Kerala",
      "Delhi",
      "West Bengal",
      "Goa",
      "Himachal Pradesh",
      "Karnataka",
      "Meghalaya",
      "Nagaland",
      "Bihar",
      "Puducherry",
      "Chhattisgarh",
      "Arunachal Pradesh",
      "Jharkhand",
      "Haryana",
      "Manipur",
      "Mizoram",
      "Odisha",
      "Assam",
      "Jammu & Kashmir",
      "Tamil Nadu",
      "Uttarakhand",
      "Telangana",
      "Gujarat",
      "Maharashtra",
      "Andhra Pradesh",
      "Chandigarh"
    ];

    List<String> category = [
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

    List<String> subCategory = [
      'Please Select Gender',
      'Gender-Neutral',
      'Female-Only',
    ];
    List<String> exam = [
      'JEE Main',
      'JEE Advanced',
    ];
    List<String> josaaCounselling = [
      'JOSAA',
      'CSAB',
    ];

    Widget examWidgetToDisplay = const SizedBox();
    Widget counsellingWidgetToDisplay = const SizedBox();

    if (counselling == "JOSAA") {
      examWidgetToDisplay = detailsDropdown("Select the Exam", exam, size,
          (value) {
        setState(() {
          selectedExam = value;
        });
      }, "Enter Exam Details",
          "Your Exam Could be Either JEE Mains or JEE Advanced, For JEE Advanced you'll be shown only IIT's and for JEE Mains there will not be IIT's.");
    }

    if (counselling == "JOSAA" && selectedExam == "JEE Main") {
      counsellingWidgetToDisplay = detailsDropdown(
          "Select the Counselling", josaaCounselling, size, (value) {
        setState(() {
          selectedCounselling = value;
        });
      }, "Enter Counselling details",
          "For $counselling Counselling, We Have JOSAA and CSAB, please select the counselling based on your rank, Always Remember in CSAB counselling your CRL Rank will be applicable irrespective of your category but in JOSAA, your Category Rank will be applicable.");
    }

    if (selectedCategory == 'OPEN') {
      rankToEnter = "CRL Rank";
    } else {
      rankToEnter = "Category Rank";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$counselling Branch Predictor",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            width: size * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/images/dashboard_images/background_new.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: size,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const MyCarouselSlider(),
                      const SizedBox(height: 15),
                      examWidgetToDisplay,
                      counsellingWidgetToDisplay,
                      detailsDropdown(
                          "Select your domicile state", states, size, (value) {
                        setState(() {
                          selectedState = value;
                        });
                      }, "Enter Domicile Details",
                          "Domicile is the state for which you can claim the residence based on either your 12th School or your residential plot in the state."),
                      detailsDropdown("Select your category", category, size,
                          (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }, "Enter Category Details",
                          "Category for the $counselling Counselling is one of the option given for your selected category, Always remember for any Counselling other than JOSAA, your category is only applicable if the counselling state is your Home State."),
                      detailsDropdown(
                          "Select your subCategory", subCategory, size,
                          (value) {
                        setState(() {
                          selectedSubCategory = value;
                        });
                        showBranchSelectionBottomSheet();
                      }, "Enter Sub-Category Details",
                          "Sub Category for the $counselling Counselling is one of the option given for your selected category, These could be your gender benifits, Fee waiver, any disability, Defence benifits."),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 56, top: 12, bottom: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _controller.userRank,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(10, 10)),
                              ),
                              label: Text("Enter $selectedExam $rankToEnter"),
                              prefixIcon: const Icon(Icons.fingerprint)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: AnimatedBtn(
                      press: () async {
                        setState(() {
                          isLoading = true;
                        });

                        int userRank = int.parse(_controller.userRank.text);

                        if (userRank.isNaN ||
                            userRank.isNegative ||
                            userRank.isInfinite ||
                            userRank.toString() == "") {
                          showDialog(
                            barrierDismissible: true,
                            useSafeArea: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Colors.white,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(16.0)),
                                          child: Image.asset(
                                            "assets/gif/faq.gif",
                                            width: double.maxFinite,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "$selectedExam 2024 Rank",
                                                style: GoogleFonts.lato(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                "Please Enter a valid $selectedExam Rank For our better assistance in your college Admission.",
                                                style: GoogleFonts.lato(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                    fontStyle:
                                                        FontStyle.italic),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          try {
                            final data =
                                await _controller.getCollegesByBranches(
                                    selectedState,
                                    selectedCategory,
                                    selectedSubCategory,
                                    userRank,
                                    counselling,
                                    selectedExam,
                                    selectedBranches);

                            // Delay for better visual feedback
                            await Future.delayed(const Duration(seconds: 2));

                            Get.to(() => ShowColleges(
                                  collegesToShow: data,
                                  counsellingName: counselling.toString(),
                                  userDetails: [
                                    counselling,
                                    selectedState,
                                    selectedCategory,
                                    selectedSubCategory,
                                    userRank.toString(),
                                  ],
                                ));
                          } catch (error) {
                            // Handle errors if necessary
                            print("Error: $error");
                          } finally {
                            // Ensure isLoading is set to false even if there's an error
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      buttonText: "Get Colleges",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
                    child: Text(
                      "Counselling support & Guidance, College Cutoff details and College Features and comparing different colleges.",
                      style: TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 78, 78, 78)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: size / 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsDropdown(String hint, List<String> list, double mobileWidth,
      Function(String) onChanged, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: mobileWidth - 80,
            child: CustomDropdown<String>(
              closedFillColor: Colors.transparent,
              closedBorder:
                  Border.all(color: const Color.fromARGB(255, 138, 136, 136)),
              hintText: hint,
              items: list,
              initialItem: list[0],
              onChanged: (value) {
                onChanged(value);

                log('changing value to: $value');
              },
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.info_rounded,
              size: 30,
              color: tAccentColor,
            ),
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return const AlertDialog(
              //       title: Text("What"),
              //     );
              //   },
              // );
              showInformation(context, title, description);
            },
          ),
        ],
      ),
    );
  }

  showBranchSelectionBottomSheet() {
    return showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: ListView.builder(
                itemCount: branches.length,
                itemBuilder: (BuildContext context, int index) {
                  String branch = branches[index];
                  bool isSelected = selectedBranches.contains(branch);

                  return ListTile(
                    title: Text(branch),
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedBranches.add(branch);
                            } else {
                              selectedBranches.remove(branch);
                            }
                            // Update the selected branches in the main screen
                          }
                        });
                        print(selectedBranches);
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> showInformation(
    BuildContext context, String title, String description) {
  return showDialog(
    barrierDismissible: true,
    useSafeArea: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.asset(
                    "assets/gif/faq.gif",
                    width: double.maxFinite,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        description,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.black87,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}

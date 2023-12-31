import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_colleges.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CollegePredictor extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String counselling_name;

  // ignore: non_constant_identifier_names
  const CollegePredictor({super.key, required this.counselling_name});

  @override
  State<CollegePredictor> createState() => _CollegePredictorState();
}

class _CollegePredictorState extends State<CollegePredictor> {
  bool isLoading = false;
  final _controller = Get.put(CollegePredictorController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String selectedState = "Punjab";
  String selectedCategory = "EWS";
  String selectedSubCategory = "Gender-Neutral";
  String selectedExam = "JEE Main";
  String selectedCounselling = "JOSAA";
  String rankToEnter = "CRL Rank";

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
      },
          "Enter Exam Details",
          "Your Exam Could be Either JEE Mains or JEE Advanced, For JEE Advanced you'll be shown only IIT's and for JEE Mains there will not be IIT's.",
          context);
    }

    if (counselling == "JOSAA" && selectedExam == "JEE Main") {
      counsellingWidgetToDisplay = detailsDropdown(
          "Select the Counselling", josaaCounselling, size, (value) {
        setState(() {
          selectedCounselling = value;
        });
      },
          "Enter Counselling details",
          "For $counselling Counselling, We Have JOSAA and CSAB, please select the counselling based on your rank, Always Remember in CSAB counselling your CRL Rank will be applicable irrespective of your category but in JOSAA, your Category Rank will be applicable.",
          context);
    }

    if (selectedCounselling == "CSAB") {
      rankToEnter = "CRL Rank";
    } else if (selectedCounselling == "JOSAA") {
      if (selectedCategory == 'OPEN') {
        rankToEnter = "CRL Rank";
      } else {
        rankToEnter = "Category Rank";
      }
    }

    return Scaffold(
      backgroundColor: isDark
          ? const Color.fromARGB(255, 19, 19, 19)
          : const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Get.back();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: isDark ? Colors.white : const Color(0xFF14181B),
            size: 32,
          ),
        ),
        title: Text(
          'College Predictor',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 100),
                          fadeOutDuration: const Duration(milliseconds: 100),
                          imageUrl:
                              'https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public/utility_images/public/Purple%20and%20Blue%20Gradient%20Modern%203D%20Illusrtative%20Creative%20Marketing%20Agency%20Banner%20(2).png',
                          width: MediaQuery.sizeOf(context).width,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 16, 0, 0),
                          child: Text(
                            "College Predictor",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF14181B),
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 8, 0, 0),
                          child: Text(
                            counselling,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: isDark
                                  ? const Color.fromARGB(255, 169, 160, 254)
                                  : const Color(0xFF4B39EF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 12, 20, 4),
                          child: Text(
                            'The best of all 3 worlds, Row & Flow offers high intensity rowing and strength intervals followed by athletic based yoga sure to enhance flexible and clear the mind.',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: isDark
                                  ? const Color.fromARGB(255, 178, 176, 176)
                                  : const Color(0xFF57636C),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 24,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFFE0E3E7),
                        ),
                        ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.black : Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x2F1D2429),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      examWidgetToDisplay,
                                      counsellingWidgetToDisplay,
                                      detailsDropdown(
                                          "Select your domicile state",
                                          states,
                                          size, (value) {
                                        setState(() {
                                          selectedState = value;
                                        });
                                      },
                                          "Enter Domicile Details",
                                          "Domicile is the state for which you can claim the residence based on either your 12th School or your residential plot in the state.",
                                          context),
                                      detailsDropdown("Select your category",
                                          category, size, (value) {
                                        setState(() {
                                          selectedCategory = value;
                                        });
                                      },
                                          "Enter Category Details",
                                          "Category for the $counselling Counselling is one of the option given for your selected category, Always remember for any Counselling other than JOSAA, your category is only applicable if the counselling state is your Home State.",
                                          context),
                                      detailsDropdown("Select your subCategory",
                                          subCategory, size, (value) {
                                        setState(() {
                                          selectedSubCategory = value;
                                        });
                                      },
                                          "Enter Sub-Category Details",
                                          "Sub Category for the $counselling Counselling is one of the option given for your selected category, These could be your gender benifits, Fee waiver, any disability, Defence benifits.",
                                          context),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14, bottom: 12),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _controller.userRank,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              label: Text(
                                                  "Enter $selectedExam $rankToEnter"),
                                              prefixIcon:
                                                  const Icon(Icons.numbers)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
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
                            await Future.delayed(
                                const Duration(milliseconds: 100));

                            final data =
                                await _controller.predictCollegesUsingExcel(
                              selectedCounselling,
                              selectedCategory,
                              selectedSubCategory,
                              userRank,
                              selectedState,
                              selectedExam,
                            );

                            // Delay for better visual feedback
                            await Future.delayed(
                                const Duration(milliseconds: 100));

                            Get.to(() => ShowColleges(
                                  collegesToShow: data,
                                  counsellingName: selectedCounselling,
                                  userDetails: [
                                    selectedCounselling,
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
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        ),
                        backgroundColor: MaterialStatePropertyAll(tAccentColor),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(3),
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        side: MaterialStatePropertyAll(
                          BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Text("Get Colleges"),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Adjust the opacity as needed
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
      ),
    );
  }

  Future<void> showInformation(
      BuildContext context, String title, String description) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
              color: isDark ? Colors.black : Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.titleMedium,
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
}

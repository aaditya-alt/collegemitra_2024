import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollegePredictor extends StatefulWidget {
  final String counselling_name;

  // ignore: non_constant_identifier_names
  CollegePredictor({super.key, required this.counselling_name});

  @override
  State<CollegePredictor> createState() => _CollegePredictorState();
}

class _CollegePredictorState extends State<CollegePredictor> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(CollegePredictorController());

    List<DropdownMenuEntry<dynamic>> domicileList = [
      const DropdownMenuEntry(value: 'Odisha', label: 'Odisha'),
      const DropdownMenuEntry(value: 'Other State', label: 'Other State'),
    ];

    List<DropdownMenuEntry<dynamic>> categoryList = [
      const DropdownMenuEntry(value: 'OPEN', label: 'OPEN'),
      const DropdownMenuEntry(value: 'OBC', label: 'OBC'),
      const DropdownMenuEntry(value: 'EWS', label: 'EWS'),
      const DropdownMenuEntry(value: 'SC', label: 'SC'),
    ];

    List<DropdownMenuEntry<dynamic>> subCategoryList = [
      const DropdownMenuEntry(value: 'Gender-Neutral', label: 'Gender-Neutral'),
      const DropdownMenuEntry(value: 'Female', label: 'Female'),
    ];
    var counselling;
    if (widget.counselling_name == "GGSIPU Delhi") {
      counselling = "GGSIPU";
    } else if (widget.counselling_name == "JAC Delhi") {
      counselling = "JACD";
    } else {
      counselling = widget.counselling_name;
    }
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
        child: Column(
          children: [
            const MyCarouselSlider(),
            const SizedBox(height: 20),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Asking user to fill domicile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu(
                      controller: controller.domicile,
                      inputDecorationTheme: InputDecorationTheme(
                        contentPadding: const EdgeInsets.all(10),
                        border: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: isDark ? Colors.black : tPrimaryColor,
                              style: BorderStyle.solid,
                            )),
                      ),
                      dropdownMenuEntries: domicileList,
                      width: MediaQuery.of(context).size.width - 80,
                      menuStyle: MenuStyle(
                          alignment: Alignment.center,
                          elevation: const MaterialStatePropertyAll(4),
                          backgroundColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white),
                          surfaceTintColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white)),
                      label: const Text('Select State'),
                    ),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 28,
                      color: tPrimaryColor,
                    ),
                  ],
                ),

                //Asking user to fill category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu(
                      controller: controller.category,
                      inputDecorationTheme: const InputDecorationTheme(
                        contentPadding: EdgeInsets.all(10),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: tPrimaryColor,
                              style: BorderStyle.solid,
                            )),
                      ),
                      dropdownMenuEntries: categoryList,
                      width: MediaQuery.of(context).size.width - 80,
                      menuStyle: MenuStyle(
                          alignment: Alignment.center,
                          elevation: const MaterialStatePropertyAll(4),
                          backgroundColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white),
                          surfaceTintColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white)),
                      label: const Text('Select Category'),
                    ),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 28,
                      color: tPrimaryColor,
                    ),
                  ],
                ),

                //Asking user to fill subCategory
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu(
                      controller: controller.subCategory,
                      inputDecorationTheme: const InputDecorationTheme(
                        contentPadding: EdgeInsets.all(10),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: tPrimaryColor,
                              style: BorderStyle.solid,
                            )),
                      ),
                      dropdownMenuEntries: subCategoryList,
                      width: MediaQuery.of(context).size.width - 80,
                      menuStyle: MenuStyle(
                          alignment: Alignment.center,
                          elevation: const MaterialStatePropertyAll(4),
                          backgroundColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white),
                          surfaceTintColor: MaterialStatePropertyAll(
                              isDark ? Colors.black : Colors.white)),
                      label: const Text('Select Sub-Category'),
                    ),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 28,
                      color: tPrimaryColor,
                    ),
                  ],
                ),

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
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: tPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
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
                              controller.setLoading(true);

                              if (controller.category.text.trim() == "") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Please Select the Category"),
                                    );
                                  },
                                ).then((_) {
                                  controller.setLoading(false);
                                });
                              } else if (controller.subCategory.text.trim() ==
                                  "") {
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
                              } else if (controller.domicile.text.trim() ==
                                  "") {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("Please Select the Domicile"),
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
                                  controller.category.text.trim(),
                                  controller.subCategory.text.trim(),
                                  int.parse(controller.userRank.text.trim()),
                                  controller.domicile.text.trim(),
                                );
                                controller.setLoading(false);
                              }
                            },
                      icon: Obx(() {
                        if (controller.isLoading.value) {
                          return const SizedBox(
                            width: 21.0, // Adjust the width to make it smaller
                            height:
                                21.0, // Adjust the height to make it smaller
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
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
      ),
    );
  }
}

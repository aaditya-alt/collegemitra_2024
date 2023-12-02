import 'dart:developer';
import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/features/authentication/models/services_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BestServices extends StatefulWidget {
  const BestServices({super.key});

  @override
  State<BestServices> createState() => _BestServicesState();
}

class _BestServicesState extends State<BestServices> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<freeService> freeServices = [
      freeService(
          image: 'assets/images/dashboard_images/nta.png',
          title: 'Rank Predictor',
          subTitle: 'Predict Your JEE Rank'),
      freeService(
          image: 'assets/images/dashboard_images/nta.png',
          title: 'College Predictor',
          subTitle: 'Predict Desired College'),
      freeService(
          image: 'assets/images/dashboard_images/nta.png',
          title: 'Compare Colleges',
          subTitle: 'Compare the Colleges'),
      freeService(
          image: 'assets/images/dashboard_images/nta.png',
          title: 'College List',
          subTitle: 'Get College List'),
    ];

    List<String> counsellingList = [
      "JOSAA",
      "UPTU",
      "HSTES",
      "JAC Delhi",
      "GGSIPU Delhi"
          "REAP",
      "OJEE"
    ];
    String selectedCounselling = "JOSAA";
    return Stack(
      children: [
        SizedBox(
          height: size.height / 4.5,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: freeServices.length,
              itemBuilder: (BuildContext context, int i) => GestureDetector(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (freeServices[i].title == "Rank Predictor") {
                          Get.to(() => RankPredictor(counsellingName: null));
                        } else if (freeServices[i].title ==
                            "College Predictor") {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: size.height - 2,
                                  width: size.width - 20,
                                  child: AlertDialog(
                                    elevation: 4,
                                    actions: [
                                      const SizedBox(height: 20),
                                      Text(
                                        "Select the Counselling",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: SizedBox(
                                          width: size.width - 80,
                                          child: CustomDropdown<String>(
                                            closedFillColor: Colors.transparent,
                                            closedBorder: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 138, 136, 136)),
                                            hintText: "Select the Counselling",
                                            items: counsellingList,
                                            initialItem: counsellingList[0],
                                            onChanged: (value) {
                                              selectedCounselling = value;
                                              log('changing value to: $value');
                                            },
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () => Get.to(() =>
                                              CollegePredictor(
                                                  counselling_name:
                                                      selectedCounselling)),
                                          child: const Text("   Go ahead   ")),
                                    ],
                                  ),
                                );
                              });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          width: size.width / 1.8,
                          height: 145,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.yellow],
                              // Adjust stops as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    freeServices[i].image,
                                    height: 60,
                                    width: 180,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  freeServices[i].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  freeServices[i].subTitle,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
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
    );
  }
}

Widget services() {
  final List<Color> gradientColors = [const Color(0xFFADD8E6), Colors.white];
  return Container(
    width: 180,
    height: 160,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0], // Adjust stops as needed
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/dashboard_images/nta.jpg",
              height: 60,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            "Rank Predictor",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Predict your JEE Mains Rank",
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}

class freeService {
  final String image;
  final String title;
  final String subTitle;
  freeService({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

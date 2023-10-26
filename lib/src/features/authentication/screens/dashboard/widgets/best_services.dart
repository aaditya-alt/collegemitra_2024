import 'dart:ui';

import 'package:collegemitra/src/features/authentication/models/services_model.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BestServices extends StatelessWidget {
  const BestServices({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final List<Color> gradientColors = [
      const Color.fromARGB(255, 127, 216, 238),
      const Color.fromARGB(255, 251, 244, 244)
    ];
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
    return SizedBox(
      height: 145,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: freeServices.length,
          itemBuilder: (BuildContext context, int i) => GestureDetector(
                child: Card(
                  child: Container(
                    width: 180,
                    height: 145,
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
              )),
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

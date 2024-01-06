import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
      "GGSIPU Delhi",
      "REAP",
      "OJEE"
    ];
    String selectedCounselling = "JOSAA";

    return Stack(
      children: [
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: freeServices.length,
            itemBuilder: (BuildContext context, int i) => GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  if (freeServices[i].title == "Rank Predictor") {
                    Get.to(() => RankPredictor(counsellingName: null));
                  } else if (freeServices[i].title == "College Predictor") {
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
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: SizedBox(
                                  width: size.width - 80,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: counsellingList
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedCounselling,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedCounselling = value!;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 40,
                                        width: 140,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Get.to(() => CollegePredictor(
                                    counselling_name: selectedCounselling)),
                                child: const Text("   Go ahead   "),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: Row(
                  children: [
                    newCard(context, freeServices[i].title),
                    const SizedBox(width: 15),
                  ],
                )),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Image.asset(
                "assets/gif/loader.gif",
                width: size.width / 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
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

Widget newCard(BuildContext context, String title) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return // Generated code for this Container Widget...
      Container(
    width: MediaQuery.sizeOf(context).width * 0.44,
    height: 106,
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
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Container(
            width: 60,
            height: 24,
            decoration: BoxDecoration(
              color: tAccentColor.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Free",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Lexend',
                      color: tAccentColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

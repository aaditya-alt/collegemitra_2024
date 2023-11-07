import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_list_items.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounsellingButton extends StatelessWidget {
  CounsellingButton({super.key, required this.listItems});

  @override
  final List<CustomIcon> listItems;

  // ignore: non_constant_identifier_names
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          counsellingRow(listItems, context),
        ],
      ),
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;
  var counselling;

  CustomIcon({
    required this.icon,
    required this.name,
    this.counselling,
  });
}

Widget counsellingRow(List icons, BuildContext context) {
  bool isLoading = false;
  final controller = Get.put(CollegePredictorController());
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  List<CustomIcon> customIcons = [
    CustomIcon(
        icon: "assets/images/dashboard_images/counselling_images/josaa.png",
        name: "JOSAA"),
    CustomIcon(
        icon: "assets/images/dashboard_images/counselling_images/jacd.png",
        name: "JAC Delhi"),
    CustomIcon(
        icon: "assets/images/dashboard_images/counselling_images/ggsipu.png",
        name: "GGSIPU Delhi"),
    CustomIcon(
        icon: "assets/images/dashboard_images/counselling_images/uptu.png",
        name: "UPTU"),
  ];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: List.generate(icons.length, (index) {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              isLoading = true;
              if (icons[index].name == 'More') {
                bottomSheet(context);
              } else if (icons[index].name == 'College Predictor') {
                Get.to(() => CollegePredictor(
                      counselling_name: icons[index].counselling,
                    ));
              } else {
                Get.to(() => FeatureScreen(appBarTitle: icons[index].name));
              }
            },
            borderRadius: BorderRadius.circular(90),
            child: Container(
              padding: const EdgeInsets.all(3),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? tSecondaryColor : Colors.white,
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            isDark ? Colors.white : tSecondaryColor),
                        strokeWidth: 4.0,
                      ),
                    )
                  : Center(
                      child: Image.asset(
                        icons[index].icon,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            icons[index].name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      );
    }),
  );
}

Future bottomSheet(BuildContext context) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => Container(
            color: isDark ? tSecondaryColor : Colors.white,
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Mentorship",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Engineering Counselling and Mentorship Details...",
                      style: Theme.of(context).textTheme.bodySmall),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        counsellingRow(customIcons, context),
                        const SizedBox(height: 25),
                        counsellingRow(customIcons, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}

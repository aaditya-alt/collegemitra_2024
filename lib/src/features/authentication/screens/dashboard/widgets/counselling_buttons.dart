import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/college_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/show_all_colleges.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/branch_predictor/branch_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/details/details_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_list_items.dart';
import 'package:collegemitra/src/repository/authentication_repository/excel_college_predictor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounsellingButton extends StatefulWidget {
  const CounsellingButton({super.key, required this.listItems});

  final List<CustomIcon> listItems;

  @override
  State<CounsellingButton> createState() => _CounsellingButtonState();
}

class _CounsellingButtonState extends State<CounsellingButton> {
  final controller = Get.put(CollegePredictorController());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return counsellingRow(widget.listItems, context);
  }

  Widget counsellingRow(List icons, BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Future bottomSheet(BuildContext context) {
      List<CustomIcon> customIcons = [
        CustomIcon(
            icon: "assets/images/dashboard_images/counselling_images/josaa.png",
            name: "JOSAA"),
        CustomIcon(
            icon: "assets/images/dashboard_images/counselling_images/jacd.png",
            name: "JAC Delhi"),
        CustomIcon(
            icon:
                "assets/images/dashboard_images/counselling_images/ggsipu.png",
            name: "GGSIPU Delhi"),
        CustomIcon(
            icon: "assets/images/dashboard_images/counselling_images/uptu.png",
            name: "UPTU"),
      ];
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
                        padding: const EdgeInsets.only(top: 20),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(icons.length, (index) {
        return Stack(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (icons[index].name == 'More') {
                      bottomSheet(context);
                    } else if (icons[index].name == 'Predictor') {
                      Get.to(() => CollegePredictor(
                            counselling_name: icons[index].counselling,
                          ));
                    } else if (icons[index].name == "Predict Rank") {
                      Get.to(() => RankPredictor(
                          counsellingName: icons[index].counselling));
                    } else if (icons[index].name == "Branch") {
                      Get.to(() => BranchPredictor(
                          counselling_name: icons[index].counselling));
                    } else if (icons[index].name == "Know About") {
                      Get.to(() => DetailsScreen(
                          counsellingName: icons[index].counselling));
                    } else if (icons[index].name == "All Colleges") {
                      Get.to(() => const ShowAllColleges());
                    } else {
                      Get.to(
                          () => FeatureScreen(appBarTitle: icons[index].name));
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(90),
                  child: Container(
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
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
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
                    width: MediaQuery.of(context).size.height / 4,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
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

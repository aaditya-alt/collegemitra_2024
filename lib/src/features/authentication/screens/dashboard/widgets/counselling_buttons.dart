import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/compare_colleges/compare_colleges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/show_all_colleges.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/branch_predictor/branch_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/details/details_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features_screen.dart';

class CounsellingButton extends StatefulWidget {
  const CounsellingButton({super.key, required this.listItems});

  final List<CustomIcon> listItems;

  @override
  State<CounsellingButton> createState() => _CounsellingButtonState();
}

class _CounsellingButtonState extends State<CounsellingButton> {
  bool isLoading = false;
  int? loadingIndex; // Track the index of the icon being loaded

  @override
  Widget build(BuildContext context) {
    return counsellingRow(widget.listItems, context);
  }

  Widget counsellingRow(List icons, BuildContext context) {
    late bool isDark;
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                      loadingIndex = index; // Set the loading index
                    });

                    await handleIconTap(icons[index], context);
                    setState(() {
                      isLoading = false;
                      loadingIndex = null; // Reset the loading index
                    });
                  },
                  borderRadius: BorderRadius.circular(90),
                  child: buildIconContainer(icons[index], isDark, index),
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
          ],
        );
      }),
    );
  }

  Widget buildIconContainer(CustomIcon icon, bool isDark, int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? Colors.transparent : Colors.white,
      ),
      child: buildIconContent(icon, isDark, index),
    );
  }

  Widget buildIconContent(CustomIcon icon, bool isDark, int index) {
    return isLoading && loadingIndex == index
        ? buildLoadingIndicator(isDark)
        : Center(
            child: Image.asset(
              icon.icon,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget buildLoadingIndicator(bool isDark) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            isDark ? Colors.white : tSecondaryColor),
        strokeWidth: 4.0,
      ),
    );
  }

  Future<void> handleIconTap(CustomIcon icon, BuildContext context) async {
    switch (icon.name) {
      case 'More':
        await bottomSheet(context);
        break;
      case 'Predictor':
        Get.to(() => CollegePredictor(
              counselling_name: icon.counselling,
            ));
        break;
      case 'Predict Rank':
        Get.to(() => RankPredictor(counsellingName: icon.counselling));
        break;
      case 'Branch':
        Get.to(() => BranchPredictor(counselling_name: icon.counselling));
        break;
      case 'Know About':
        Get.to(() => DetailsScreen(counsellingName: icon.counselling));
        break;
      case 'All Colleges':
        Get.to(() => ShowAllColleges(
              counselling: icon.counselling,
            ));
        break;
      case 'Comparison':
        Get.to(() => CompareColleges(
              counsellingName: icon.counselling,
            ));
      default:
        Get.to(() => FeatureScreen(appBarTitle: icon.name));
    }
  }

  Future<void> bottomSheet(BuildContext context) async {
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

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => buildBottomSheetContent(context, customIcons),
    );
  }

  Widget buildBottomSheetContent(
      BuildContext context, List<CustomIcon> customIcons) {
    return Container(
      color: Colors.white,
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
            Text(
              "Engineering Counselling and Mentorship Details...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
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
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;
  // ignore: prefer_typing_uninitialized_variables
  var counselling;

  CustomIcon({
    required this.icon,
    required this.name,
    this.counselling,
  });
}

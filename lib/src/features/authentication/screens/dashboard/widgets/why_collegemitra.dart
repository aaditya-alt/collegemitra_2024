import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhyCollegemitra extends StatelessWidget {
  const WhyCollegemitra({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(
          icon: "assets/images/dashboard_images/shield.png", name: "Assured"),
      CustomIcon(
          icon: "assets/images/dashboard_images/3d-fire.png",
          name: "Fantastic"),
      CustomIcon(
          icon: "assets/images/dashboard_images/love.png",
          name: "Love & Support"),
      CustomIcon(
          icon: "assets/images/dashboard_images/3d-target.png",
          name: "Accuracy"),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          whyCollegemitra(customIcons, context),
        ],
      ),
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;
  CustomIcon({
    required this.icon,
    required this.name,
  });
}

Widget whyCollegemitra(List icons, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(icons.length, (index) {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(3),
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  icons[index].icon,
                  fit: BoxFit.cover,
                ),
              )),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounsellingButton extends StatelessWidget {
  const CounsellingButton({super.key});

  @override
  Widget build(BuildContext context) {
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

    List<CustomIcon> allCounselling = [
      CustomIcon(
          icon: "assets/images/dashboard_images/counselling_images/reap.png",
          name: "REAP"),
      CustomIcon(
          icon: "assets/images/dashboard_images/counselling_images/hstes.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/counselling_images/ojee.png",
          name: "OJEE"),
      CustomIcon(
          icon: "assets/images/dashboard_images/counselling_images/more.png",
          name: "More"),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          counsellingRow(customIcons, context),
          const SizedBox(height: 15),
          counsellingRow(allCounselling, context),
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

Widget counsellingRow(List icons, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(icons.length, (index) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              if (icons[index].name == 'More') {
                print('More Counselling Show on bottomsheet');
              } else {
                print(icons[index].name);
              }
            },
            borderRadius: BorderRadius.circular(90),
            child: Container(
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

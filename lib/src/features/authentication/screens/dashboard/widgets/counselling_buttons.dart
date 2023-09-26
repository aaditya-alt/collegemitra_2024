import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounsellingButton extends StatelessWidget {
  const CounsellingButton({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
    ];

    List<CustomIcon> allCounselling = [
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
      CustomIcon(
          icon: "assets/images/dashboard_images/hero_section.png",
          name: "HSTES"),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(customIcons.length, (index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (index == customIcons.length - 1) {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      showDragHandle: true,
                      builder: (context) {
                        return Container(
                          height: 350,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //All Counsellings
                              Text(
                                "All Counsellings",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 15),

                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(allCounselling.length,
                                      (index) {
                                    return Column(
                                      children: [
                                        Container(
                                            width: 60,
                                            height: 60,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer
                                                  .withOpacity(0.4),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                allCounselling[index].icon,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      ],
                                    );
                                  }))
                            ],
                          ),
                        );
                      });
                }
              },
              borderRadius: BorderRadius.circular(90),
              child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.4),
                  ),
                  child: Center(
                    child: Image.asset(
                      customIcons[index].icon,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            const SizedBox(height: 6),
            Text(customIcons[index].name),
          ],
        );
      }),
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

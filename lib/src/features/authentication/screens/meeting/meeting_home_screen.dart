import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/history_meeting_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/meeting_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/premium_purchase.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MeetingHomeScreen extends StatefulWidget {
  const MeetingHomeScreen({super.key});

  @override
  State<MeetingHomeScreen> createState() => _MeetingHomeScreenState();
}

class _MeetingHomeScreenState extends State<MeetingHomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    const Text("Contacts"),
    const Text("Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: const Text("Meet & Chat"),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: NavigationBar(
        height: 65,
        elevation: 2,
        onDestinationSelected: (index) {
          if (index == 3) {
            Get.to(() => const ProfileScreen());
          } else if (index == 1) {
            Get.to(() => const MeetingHomeScreen());
          } else if (index == 2) {
            Get.to(() => const PremiumPurchase());
          } else {
            Get.to(() => const Dashboard());
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ],
      ),
    );
  }
}

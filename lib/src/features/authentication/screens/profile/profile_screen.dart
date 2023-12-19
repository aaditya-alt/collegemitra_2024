import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/profile_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_header.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_list.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/widgets/profile_menu_widget.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                const Image(image: AssetImage(tProfileImage))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            child: const Icon(LineAwesomeIcons.alternate_pencil,
                                size: 20.0, color: Colors.black)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(tProfileHeading,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(tProfileSubHeading,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
                        child: Text(tEditProfile,
                            style: TextStyle(color: tDarkColor)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                      )),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),

                  //Menu
                  ProfileMenuWidget(
                      title: "Settings",
                      icon: LineAwesomeIcons.cog,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Billing Details",
                      icon: LineAwesomeIcons.wallet,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: LineAwesomeIcons.user_check,
                      onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Information",
                      icon: LineAwesomeIcons.info,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        Get.defaultDialog(
                          title: "LOGOUT",
                          titleStyle: const TextStyle(fontSize: 20),
                          content: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text("Are you sure, you want to Logout?"),
                          ),
                          confirm: Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  AuthenticationRepository.instance.logout(),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  side: BorderSide.none),
                              child: const Text("Yes"),
                            ),
                          ),
                          cancel: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text("No")),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 3,
          onTap: (index) {
            if (index == 3) {
              Get.to(() => const ProfileScreen());
            } else if (index == 0) {
              Get.offAll(() => const Dashboard());
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_outlined), label: "Blogs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.workspace_premium_outlined), label: "Premium"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: "Profile"),
          ]),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/main.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/profile_controller.dart';
import 'package:collegemitra/src/features/authentication/controllers/theme_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/meeting_home_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/premium_purchase.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/widgets/profile_menu_widget.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/widgets/settings.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    getDetails();
    super.initState();
  }

  String fullName = "";
  String? email = "";
  String imageLink = "";

  void getDetails() async {
    final auth = AuthenticationRepository.instance;
    fullName = auth.fullName;
    email = auth.firebaseUser.value?.email;
    imageLink = auth.imageLink;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Get.back();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: isDark ? Colors.white : const Color(0xFF14181B),
            size: 32,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1,
                            color: Color(0xFFF1F4F8),
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24, 12, 24, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color.fromARGB(255, 26, 25, 25)
                                    : const Color(0xFFE0E3E7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: imageLink,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fullName,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                    child: Text(
                                      email!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: tPrimaryColor,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                    child: SizedBox(
                      width: 190,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() =>
                              UpdateProfileScreen(email: email?.toString()));
                        },
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
                          backgroundColor: MaterialStatePropertyAll(
                              isDark ? tPrimaryColor : tPrimaryColor.shade300),
                          elevation: const MaterialStatePropertyAll(3),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                //Menu
                ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog,
                    onPress: () {
                      Get.to(() => SettWidget(email: email));
                    }),
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
                        cancel: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 174, 59),
                                side: BorderSide.none),
                            onPressed: () => Get.back(),
                            child: const Text("No")),
                      );
                    }),
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
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        indicatorColor: isDark ? tPrimaryColor : tPrimaryColor.shade200,
        height: 65,
        elevation: 2,
        selectedIndex: 3,
        onDestinationSelected: (index) {
          if (index == 3) {
            Get.to(() => const ProfileScreen());
          } else if (index == 1) {
            Get.to(() => const MeetingHomeScreen());
          } else if (index == 2) {
            Get.to(() => const PremiumPurchase());
          } else {
            Get.offAll(() => const Dashboard());
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

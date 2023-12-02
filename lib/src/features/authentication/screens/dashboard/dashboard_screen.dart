import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/best_services.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/bottom_carousel.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_buttons.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_list_items.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/premium_promo.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/testimonials.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/upcoming_card.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/why_collegemitra.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_header.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_list.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/meeting_home_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/chat/chat_users.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  final username;
  const Dashboard({super.key, this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: tAccentColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(padding: EdgeInsets.only(top: 6)),
            Text(
              "Hey ${widget.username}",
              style: const TextStyle(fontSize: 16),
            ),
            Text("How are you feeling today?",
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const ProfileScreen()),
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(14.0),
        children: [
          const MyCarouselSlider(),
          //upcoming card
          // const UpcomingCard(),
          const SizedBox(height: 20),
          Text(
            "Explore Mentorship",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Engineering Counselling and Mentorship Details...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          //counsellings
          CounsellingButton(listItems: customIcons),
          const SizedBox(height: 15),
          CounsellingButton(listItems: allCounselling),
          const SizedBox(height: 30),

          Text(
            "Best Services",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Try out some Free & Best Services by Us...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 15),

          //services
          const BestServices(),

          const SizedBox(height: 25),

          Text(
            "Popular Blogs",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Explore Counselling knowledge in Blogs...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 15),

          //Popular Blogs
          const PopularBlogs(),

          const SizedBox(height: 13),

          //Collegemitra premium promotion
          const PromoCard(),

          const SizedBox(
            height: 25,
          ),

          Text(
            "Our Mentorship",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Explore Fantastic reviews by our students...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 15),

          //Testimonial Section
          const TestimonialSection(),

          const SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                // Replace this with the desired icon
                color: Colors.white,
                // Icon color
              ),
              label: const Text(
                'Get Premium Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 129, 39), // Button color

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.all(16), // Adjust the padding as needed
              ),
            ),
          ),

          const SizedBox(height: 20),

          Image.asset(
            'assets/images/dashboard_images/reminder.png',
            width: MediaQuery.sizeOf(context).width,
          ),

          const SizedBox(height: 10),
          Text(
            "Why Collegemitra?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // Text("Explore Fantastic reviews by our students...",
          //     style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 18),

          const WhyCollegemitra(),

          const SizedBox(height: 30),

          //Bottom Corousel Slider
          const BottomCarousel(),
        ],
      ),
      // drawer: Drawer(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         MyHeaderDrawer(),
      //         const DrawerList(),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: tAccentColor.shade100,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: tPrimaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (index) {
            if (index == 3) {
              Get.to(() => const ProfileScreen());
            } else if (index == 2) {
              Get.offAll(() => const MeetingHomeScreen());
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_rounded), label: "Blogs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_membership), label: "Premium"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }

  // ignore: non_constant_identifier_names
}

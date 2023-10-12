import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/best_services.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_buttons.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/premium_promo.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/upcoming_card.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/chat/chat_users.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(padding: EdgeInsets.only(top: 6)),
            const Text("Hii Jane"),
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
          const CounsellingButton(),
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

          const SizedBox(height: 16),

          //Collegemitra premium promotion
          const PromoCard(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_outlined), label: "Blogs"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.workspace_premium_outlined)),
                label: "Premium"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () => Get.to(() => const ProfileScreen()),
                    child: const Icon(Icons.person_2_outlined)),
                label: "Profile"),
          ]),
    );
  }
}

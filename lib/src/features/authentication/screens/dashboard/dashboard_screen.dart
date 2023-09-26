import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/best_services.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_buttons.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/upcoming_card.dart';
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
              onPressed: () {},
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
          //upcoming card
          const UpcomingCard(),
          const SizedBox(height: 20),
          Text(
            "Counsellings...",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          //counsellings
          const CounsellingButton(),
          const SizedBox(height: 30),

          Text(
            "Best Services",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),

          //services
          const BestServices(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
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

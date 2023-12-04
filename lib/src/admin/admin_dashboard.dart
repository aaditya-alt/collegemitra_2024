import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepository.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (() => auth.logout()), icon: const Icon(Icons.logout))
        ],
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          MyCarouselSlider(),
        ],
      ),
    );
  }
}

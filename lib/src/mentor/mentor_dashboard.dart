import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MentorInProgressScreen extends StatelessWidget {
  const MentorInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor Panel"),
        backgroundColor: tPrimaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                await auth.logout();
                Get.offAll(() => const WelcomeScreen());
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: const Text("Mentor Panel is in progress, please check later."),
    );
  }
}

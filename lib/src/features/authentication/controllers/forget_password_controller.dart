import 'dart:async';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  late Timer _timer;

  final email = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    selfTimerForAutoRedirect();
  }

  Future<void> sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void selfTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        Get.back(); // Call a function to sign in the user
      }
    });
  }

  void manuallyCheckEmailVerification() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    final auth = AuthenticationRepository.instance;
    if (user != null && user.emailVerified) {
      auth.getUserData(user.email);
      auth.setInitialScreen(user, auth.userRole);
    }
  }
}

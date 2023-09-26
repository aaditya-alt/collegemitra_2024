import 'dart:async';

import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    selfTimerForAutoRedirect();
  }

  Future<void> sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  void selfTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }

  void manuallyCheckEmailVerification() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      AuthenticationRepository.instance.setInitialScreen(user);
    }
  }
}

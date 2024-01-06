import 'dart:async';

import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final auth = AuthenticationRepository.instance;
      if (user!.emailVerified) {
        timer.cancel();
        auth.getUserData(user.email);
        auth.setInitialScreen(user, auth.userRole);
      }
    });
  }

  void manuallyCheckEmailVerification() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    final auth = AuthenticationRepository.instance;
    if (user!.emailVerified) {
      auth.getUserData(user.email);
      auth.setInitialScreen(user, auth.userRole);
    }
  }
}

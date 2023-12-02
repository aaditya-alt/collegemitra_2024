import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collegemitra/src/features/authentication/controllers/mail_verification_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Textfield controllers to get data from textfield
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // registerUser(String email, String password) async {
  //   await AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password);
  // }

  Future<void> createUser(UserModel user, email, password) async {
    try {
      final authUser = AuthenticationRepository.instance;
      // ignore: unrelated_type_equality_checks
      if (await authUser.createUserWithEmailAndPassword(email, password) ==
          'success') {
        await userRepo.createUser(user);
        await authUser.sendEmailVerification();
        Get.to(() => const MailVerification());
      }
    } catch (e) {
      print('User creation failed: $e');
    }
  }

  Future<void> googleSignIn() async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      auth.setInitialScreen(auth.firebaseUser.value, "User");
    } catch (e) {
      print(e.toString());
    }
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  void mailVerification() {
    AuthenticationRepository.instance.sendEmailVerification();
  }
}

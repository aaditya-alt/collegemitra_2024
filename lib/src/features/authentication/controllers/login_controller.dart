import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login() async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      // After successful login, you can navigate to the appropriate screen.
    } catch (e) {
      // Handle any exceptions here (e.g., display an error message).
      print('Login failed: $e');
    }
  }

  Future<void> googleSignIn() async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      print(e.toString());
    }
  }
}

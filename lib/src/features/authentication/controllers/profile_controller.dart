import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

//Instances
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  //Step-3 : Get user email and pass to userRepo to fetch user record
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}

import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

//Instances
  final id = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final imageLink = TextEditingController();
  final role = TextEditingController();

  final _userRepo = Get.put(UserRepository());
  RxBool isLoading = false.obs;

  void startLoading() {
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }

  //Step-3 : Get user email and pass to userRepo to fetch user record
  getUserData(email) {
    print("Building future builder");
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  updateRecord(UserModel user, BuildContext context) async {
    await _userRepo.updateUserRecord(user);

    showConfirmationDialog(context,
        "Your Profile Has been Updated! Edit will take some time to show into the App");
  }
}

void showConfirmationDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
            onPressed: () {
              Navigator.pop(context);
              // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

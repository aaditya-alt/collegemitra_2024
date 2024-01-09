import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar(
            'Success',
            'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          ),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        'Error',
        'Something went wrong. Try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
      // ignore: invalid_return_type_for_catch_error
      return stackTrace;
    });
  }

  //Step-2: Fetch All users or user details
  getUserDetails(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } catch (e) {
      debugPrint("Error during getting data from firebase : ${e.toString()}");
    }
  }

  Future<List<UserModel>> getAllUserDetails() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    try {
      Box? userDataBox;
      userDataBox = Hive.box(user.email.toString());

      userDataBox.put('userRole', user.role);
      userDataBox.put('userName', user.fullName!.split(" ")[0]);
      userDataBox.put('fullName', user.fullName);
      userDataBox.put('phone', user.phoneNo);
      userDataBox.put('imageLink', user.imageLink);
      userDataBox.put('id', user.id);
      await _db
          .collection("Users")
          .doc(user.id)
          .update(user.toJson())
          .onError((e, _) => print("Error updating document: $e"));

      Get.snackbar(
        'Success',
        'Your profile has been updated!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}

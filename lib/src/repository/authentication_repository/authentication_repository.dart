import 'package:collegemitra/src/admin/admin_dashboard.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:collegemitra/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:collegemitra/src/mentor/mentor_dashboard.dart';
import 'package:collegemitra/src/repository/authentication_repository/exceptions/signup_mail_password_failure.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final _userRepo = Get.put(UserRepository());
  var userRole = "";
  String userName = "";

  // Local cache to store user data
  final Map<String, dynamic> userDataCache = {};

  Future<void> getUserData(String? email) async {
    if (email != null) {
      // Check if user data is already in the cache
      if (userDataCache.containsKey(email)) {
        final userDetails = userDataCache[email]!;
        userRole = userDetails['role'] as String;
        userName = userDetails['fullName'] as String;
        userName = userName.split(" ")[0];
      } else {
        // If not in the cache, fetch from Firebase
        print("Firebase query");
        final userDetails = await _userRepo.getUserDetails(email);
        userRole = userDetails.role.toString();
        userName = userDetails.fullName.toString();
        userName = userName.split(" ")[0];

        // Store in the cache for future use
        userDataCache[email] = {
          'role': userRole,
          'fullName': userName,
        };
      }
    } else {
      Get.snackbar("Error", "Email is null, please provide email");
    }
  }

  @override
  void onReady() async {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    if (firebaseUser.value != null) {
      await getUserData(firebaseUser.value?.email);
      setInitialScreen(firebaseUser.value, userRole);
    } else {
      Get.to(const WelcomeScreen());
    }
    // ever(firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user, String role) {
    if (user == null) {
      Get.offAll(() => const WelcomeScreen());
    } else if (user.emailVerified) {
      role == "User"
          ? Get.offAll(() => Dashboard(
                username: userName,
              ))
          : role == "Admin"
              ? Get.offAll(() => const AdminDashboard())
              : const MentorInProgressScreen();
    } else {
      Get.offAll(() => const MailVerification());
    }
  }

  //Phone Authentication
  Future<void> phoneAuthentication(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar("Error", "Phone number is not valid.");
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          print(this.verificationId.value);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
          // Optionally, you can automatically resend OTP here
          // if needed, e.g., after a timeout.
        },
      );
    } catch (e) {
      print('Error during phone authentication: $e');
      Get.snackbar('Error', 'Something went wrong. Try again.');
    }
  }

  //Verify OTP
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );
      return credentials.user != null;
    } catch (e) {
      print('Error during OTP verification: $e');
      Get.snackbar('Error', 'Invalid OTP. Please try again.');
      return false;
    }
  }

  //User sign up
  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar(
        'Error',
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar(
        'Error',
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      throw ex;
    }
  }

  //Google Authentication
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar('Error', 'Error Occured! Please Try again later.');
      throw e.hashCode;
    }
    // Trigger the authentication flow
  }

//Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

//User login
  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await getUserData(email);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        'Success',
        'Logged In.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
      setInitialScreen(firebaseUser.value, userRole);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        Get.snackbar(
          'Error',
          'Email or password entered is not Valid!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      } else {
        print('FirebaseAuth Error: ${e.code}');

        Get.snackbar(
          'Error',
          'An error occurred while logging in. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print('Error during login: $e');

      Get.snackbar(
        'Error',
        'An error occurred while logging in. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
    return null;
  }

//User Logout
  Future<void> logout() async {
    _auth.signOut();
    Get.offAll(() => const LoginScreen());
  }
}

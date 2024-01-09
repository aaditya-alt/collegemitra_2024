import 'package:collegemitra/src/admin/admin_dashboard.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/mail_verification/mail_verification.dart';
import 'package:collegemitra/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:collegemitra/src/mentor/mentor_dashboard.dart';
import 'package:collegemitra/src/repository/authentication_repository/exceptions/signup_mail_password_failure.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final _userRepo = Get.put(UserRepository());
  var userRole = "";
  String userName = "";
  String fullName = "";
  String imageLink = "";
  String phone = "";

  // Local cache to store user data
  Box? userDataBox; // Change the type to Box?

  Future<void> getUserData(String? email) async {
    if (email != null) {
      print("Fetching user data for email: $email");

      // Open a unique Hive box for each user based on email
      userDataBox = await Hive.openBox(email);

      // Check if user data is already present in Hive
      if (userDataBox!.isEmpty ||
          userDataBox!.get('userName') == "" ||
          userDataBox!.get('userRole') == "" ||
          userDataBox!.get('fullName') == "" ||
          userDataBox!.get('imageLink') == "" ||
          userDataBox!.get('phone') == "") {
        // User data is not present in Hive, fetch from Firebase
        print("User data not found in Hive, fetching from Firebase");
        var userDetails = await _userRepo.getUserDetails(email);

        // Mocking user details, replace this with actual implementation
        userRole = userDetails.role.toString();
        fullName = userDetails.fullName.toString();
        userName = fullName.split(" ")[0];
        phone = userDetails.phoneNo.toString();
        imageLink = userDetails.imageLink.toString();

        // Store user data in the user-specific Hive box
        userDataBox?.put('userRole', userRole);
        userDataBox?.put('userName', userName);
        userDataBox?.put('fullName', fullName);
        userDataBox?.put('phone', phone);
        userDataBox?.put('imageLink', imageLink);
      } else {
        // User data is already present in Hive, retrieve from Hive
        print("User data found in Hive");
        userRole = userDataBox!.get('userRole', defaultValue: "");
        userName = userDataBox!.get('userName', defaultValue: "");
        fullName = userDataBox!.get('fullName', defaultValue: "");
        phone = userDataBox!.get('phone', defaultValue: "");
        imageLink = userDataBox!.get('imageLink', defaultValue: "");
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

  void setInitialScreen(User? user, String role) {
    if (user == null) {
      Get.offAll(() => const WelcomeScreen());
    } else if (user.emailVerified) {
      if (role == "User") {
        Get.offAll(() => Dashboard(username: userName));
      } else if (role == "Admin") {
        Get.offAll(() => const AdminDashboard());
      } else if (role == "Mentor") {
        Get.offAll(() => const MentorInProgressScreen());
      } else {
        // Handle unknown role (you might want to show an error or redirect to a default screen)
        print("Unknown role: $role");
      }
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
  Future<UserCredential> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the Google sign-in
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access additional user details
      final User? user = userCredential.user;

      // Extract email, phone, and display name
      final String? email = user?.email;
      final String? phone = user
          ?.phoneNumber; // Note: Google sign-in may not provide phone number
      final String? displayName = user?.displayName;

      final userData = UserModel(
        email: email,
        password: "",
        fullName: displayName,
        phoneNo: phone,
        role: 'User',
        imageLink:
            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
      );

      await _userRepo.createUser(userData);

      // Print or use the obtained details as needed
      print('Email: $email');
      print('Phone: $phone');
      print('Display Name: $displayName');

      // Return the UserCredential
      return userCredential;
    } catch (e) {
      Get.snackbar('Error', 'Error Occurred! Please try again later.');
      throw e.hashCode;
    }
  }

  //Login with google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the Google sign-in
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Return the UserCredential
      return userCredential;
    } catch (e) {
      Get.snackbar('Error', 'Error Occurred! Please try again later.');
      throw e.hashCode;
    }
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

  //Password reset with email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle errors
      // You might want to differentiate between different error scenarios
      print("Error sending password reset email: $e");
      throw e; // Re-throw the exception for further error handling, if needed
    }
  }

//User Logout
  Future<void> logout() async {
    _auth.signOut();
    Get.offAll(() => const LoginScreen());
  }
}

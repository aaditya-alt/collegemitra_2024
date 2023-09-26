import 'package:collegemitra/src/common_widgets/form/form_header_widget.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/signup_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/signup/widgets/signup_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_field_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isGoogleLoading = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  image: tSignupLogoImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                ),
                const SignUpFormWidget(),
                Column(
                  children: [
                    const Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 209, 239, 253),
                            side: BorderSide.none,
                          ),
                          onPressed: () async {
                            setState(() {
                              isGoogleLoading = true;
                            });

                            await controller.googleSignIn();

                            setState(() {
                              isGoogleLoading = false;
                            });
                          },
                          child: isGoogleLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          21.0, // Adjust the width to make it smaller
                                      height: 21.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 3.0,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8.0), // Add spacing between the loader and text
                                    Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(tGoogleLogoImage),
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(
                                        width:
                                            8.0), // Add spacing between the image and text
                                    Text(
                                      tSignInWithGoogle,
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: tAlreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.titleMedium),
                          const TextSpan(
                            text: tLogin,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ]))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

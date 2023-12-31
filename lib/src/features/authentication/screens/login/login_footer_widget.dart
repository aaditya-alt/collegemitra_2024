import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/login_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooterWidget extends StatefulWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  State<LoginFooterWidget> createState() => _LoginFooterWidgetState();
}

class _LoginFooterWidgetState extends State<LoginFooterWidget> {
  bool isGoogleLoading = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "OR",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 209, 239, 253),
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
                          width: 21.0, // Adjust the width to make it smaller
                          height: 21.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3.0,
                          ),
                        ),
                        SizedBox(
                            width:
                                8.0), // Add spacing between the loader and text
                        Text(
                          'Loading...',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
          const SizedBox(
            height: tFormHeight - 20,
          ),
          TextButton(
            onPressed: () {
              Get.to(() => const SignUpScreen());
            },
            child: Text.rich(
              TextSpan(
                  text: tDontHaveAnAccount,
                  style: Theme.of(context).textTheme.titleSmall,
                  children: const [
                    TextSpan(
                      text: tSignup,
                      style: TextStyle(color: Colors.blue),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:collegemitra/src/common_widgets/form/form_header_widget.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/forget_password_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail_send.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  bool isValidEmail(String email) {
    // Define a regular expression for email validation
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
      multiLine: false,
    );

    // Use the RegExp's hasMatch method to check if the email is valid
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const SizedBox(height: tDefaultSize - 4),
                const FormHeaderWidget(
                  image: tForgetPasswordImage,
                  title: tForgetPassword,
                  subTitle: tForgetMailSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      decoration: const InputDecoration(
                          label: Text(tEmail),
                          hintText: tEmail,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.mail_outline_rounded)),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            String email = controller.email.text.trim();

                            if (isValidEmail(email)) {
                              try {
                                controller.sendVerificationEmail();
                                Get.to(() => PasswordResetMail(
                                      email: email,
                                    ));
                                // Navigate to password reset success or confirmation screen
                                // Example:
                                // await Get.to(() => PasswordResetConfirmationScreen());
                              } catch (e) {
                                // Handle errors (e.g., email not found, network issues)
                                print("Error sending password reset email: $e");
                                // Show an error message to the user
                                // You might want to differentiate between different error scenarios
                              }
                            } else {
                              // Handle invalid email case (show an error message, etc.)
                            }
                          },
                          child: const Text(
                            tNext,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

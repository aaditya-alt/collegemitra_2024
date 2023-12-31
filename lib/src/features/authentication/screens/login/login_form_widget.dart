import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/login_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
              ),
            ),
            const SizedBox(
              height: tFormHeight - 20,
            ),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: IconButton(
                    onPressed: null, icon: Icon(Icons.remove_red_eye_sharp)),
              ),
            ),
            const SizedBox(height: tDefaultSize - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    buildShowModalBottomSheet(context);
                  },
                  child: const Text(
                    tForgetPassword,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: tPrimaryColor),
                  )),
            ),
            const SizedBox(height: tDefaultSize),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isValidEmail(controller.email.text.trim())) {
                    setState(() {
                      isLoading = true;
                    });
                    await LoginController.instance.login();
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    Get.snackbar('Error', 'Please enter Correct Email Id.');
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                    ? const Center(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center horizontally
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Center vertically
                          children: [
                            SizedBox(
                              width:
                                  21.0, // Adjust the width to make it smaller
                              height:
                                  21.0, // Adjust the height to make it smaller
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth:
                                    3.0, // Adjust the strokeWidth to control the size
                              ),
                            ),
                            SizedBox(
                                width:
                                    8.0), // Add spacing between the icon and text
                            Text(
                              'Logging In...',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        tLogin.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

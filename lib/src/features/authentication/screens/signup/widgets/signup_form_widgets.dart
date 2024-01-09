import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/controllers/signup_controller.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
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
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    const loading = Positioned.fill(
        child: Center(
            child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.white,
      ),
    )));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                    label: Text(tFullName),
                    prefixIcon: Icon(Icons.person_outline_rounded)),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller.phoneNo,
                decoration: const InputDecoration(
                    label: Text(tPhoneNo),
                    prefixIcon: Icon(Icons.call_end_rounded)),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: controller.password,
                decoration: const InputDecoration(
                    label: Text(tPassword),
                    prefixIcon: Icon(Icons.fingerprint)),
              ),
              const SizedBox(height: tFormHeight - 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // SignUpController.instance.registerUser(
                      //     controller.email.text.trim(),
                      //     controller.password.text.trim());
                      // SignUpController.instance
                      //     .phoneAuthentication(controller.phoneNo.text.trim());

                      final user = UserModel(
                          id: controller.email.text.trim(),
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          fullName: controller.fullName.text.trim(),
                          phoneNo: controller.phoneNo.text.trim(),
                          role: 'User');

                      if (isValidEmail(controller.email.text.trim())) {
                        setState(() {
                          isLoading = true;
                        });
                        await SignUpController.instance
                            .createUser(user, user.email, user.password);
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        Get.snackbar('Error', 'Please enter Correct Email Id.');
                        setState(() {
                          isLoading = false;
                        });
                      }
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth:
                                      3.0, // Adjust the strokeWidth to control the size
                                ),
                              ),
                              SizedBox(
                                  width:
                                      8.0), // Add spacing between the icon and text
                              Text(
                                'Signing Up...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          tSignup.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          )),
    );
  }
}

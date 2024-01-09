import 'package:collegemitra/src/common_widgets/form/form_header_widget.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
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
                  subTitle: tForgetPhoneSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          hintText: tPhoneNo,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.mobile_screen_share_rounded)),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => OTPScreen(
                                    emailOrPhone: phoneController.text.trim(),
                                  ));
                            },
                            child: const Text(
                              tNext,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
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

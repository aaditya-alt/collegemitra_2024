import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/features/authentication/controllers/forget_password_controller.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetMail extends StatelessWidget {
  final String email;
  const PasswordResetMail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: tDefaultSize * 5,
              left: tDefaultSize,
              right: tDefaultSize,
              bottom: tDefaultSize * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mail_outline_rounded, size: 100),
              const SizedBox(height: tDefaultSize * 2),
              Text("Password Reset".tr,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: tDefaultSize),
              Text(
                  "We have just sent password reset link on your email. Please check email and click on that link to reset your Password.\nIf not auto redirected after reset, click on the Continue button."
                      .tr,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: tDefaultSize * 2),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                    onPressed: () =>
                        controller.manuallyCheckEmailVerification(),
                    child: Text("Continue".tr)),
              ),
              const SizedBox(height: tDefaultSize * 2),
              TextButton(
                  onPressed: () => controller.sendVerificationEmail(),
                  child: Text("Resend E-Mail Link".tr)),
              TextButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_left_rounded),
                      const SizedBox(width: 5),
                      Text("Back to login".tr.toLowerCase()),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

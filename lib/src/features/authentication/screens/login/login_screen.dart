import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginHeaderWidget(size: size),
                  const LoginForm(),
                  const LoginFooterWidget()
                ]),
          ),
        ),
      ),
    );
  }
}

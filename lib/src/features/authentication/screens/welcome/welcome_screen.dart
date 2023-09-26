import 'package:collegemitra/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:collegemitra/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:collegemitra/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/screens/login/login_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collegemitra/src/utils/theme/theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
        body: Stack(
          children: [
            TFadeInAnimation(
              durationInMs: 1200,
              animate: TAnimatePosition(
                  bottomAfter: 0,
                  bottomBefore: -100,
                  leftBefore: 0,
                  leftAfter: 0,
                  topAfter: 0,
                  topBefore: 0,
                  rightAfter: 0,
                  rightBefore: 0),
              child: Container(
                padding: EdgeInsets.all(tDefaultSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                        image: AssetImage(tWelcomeScreenImage),
                        height: height * 0.5),
                    Column(
                      children: [
                        Text(
                          tWelcomeTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          tWelcomeSubTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: OutlinedButton(
                              onPressed: () =>
                                  Get.to(() => const LoginScreen()),
                              child: Text(tLogin.toUpperCase())),
                        )),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => const SignUpScreen()),
                                child: Text(tSignup.toUpperCase())),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

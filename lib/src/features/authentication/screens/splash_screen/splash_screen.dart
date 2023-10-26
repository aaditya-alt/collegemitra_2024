import 'package:collegemitra/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:collegemitra/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:collegemitra/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: -410,
              topBefore: -390,
              leftBefore: -360,
              leftAfter: -380,
            ),
            child: const Image(image: AssetImage(tSplashTopIcon)),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(
                topBefore: 80,
                topAfter: 80,
                leftAfter: tDefaultSize,
                leftBefore: -80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tAppName, style: Theme.of(context).textTheme.displaySmall),
                Text(tAppTagLine, style: Theme.of(context).textTheme.titleSmall)
              ],
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 130),
            child: const SizedBox(
              height: 430,
              child: Image(image: AssetImage(tSplashImage)),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(
                bottomBefore: 0,
                bottomAfter: 60,
                rightBefore: tDefaultSize,
                rightAfter: tDefaultSize),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tPrimaryColor),
            ),
          )
        ],
      ),
    );
  }
}

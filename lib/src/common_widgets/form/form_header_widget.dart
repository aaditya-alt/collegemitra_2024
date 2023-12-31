import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.crossAxisAlignment,
    this.heightBetween,
    this.textAlign,
  }) : super(key: key);

  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;
  final double? heightBetween;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        Text(subTitle,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}

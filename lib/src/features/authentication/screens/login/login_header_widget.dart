import 'package:collegemitra/src/constants/image_strings.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(tLogo),
          height: size.height * 0.2,
        ),
        Text(tLoginTitle, style: Theme.of(context).textTheme.displaySmall),
        Text(tLoginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

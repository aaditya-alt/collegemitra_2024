import 'package:collegemitra/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: const Color.fromARGB(255, 70, 104, 241),
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 70, 104, 241),
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme);
}
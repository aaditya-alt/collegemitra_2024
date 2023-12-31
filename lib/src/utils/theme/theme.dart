import 'package:collegemitra/src/utils/theme/widget_themes/appbar_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      primaryColor: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationtheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationtheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme);
}

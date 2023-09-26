import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecoration lightInputDecorationtheme = const InputDecoration(
      border: OutlineInputBorder(),
      prefixIconColor: tSecondaryColor,
      floatingLabelStyle: TextStyle(color: tSecondaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: tSecondaryColor),
      ));

  static InputDecoration darkInputDecorationtheme = const InputDecoration(
      border: OutlineInputBorder(),
      prefixIconColor: tPrimaryColor,
      floatingLabelStyle: TextStyle(color: tPrimaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: tPrimaryColor),
      ));
}

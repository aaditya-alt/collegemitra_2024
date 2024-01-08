import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationtheme = InputDecorationTheme(
      errorMaxLines: 3,
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 2, color: Colors.orange)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.black12),
      ));

  static InputDecorationTheme darkInputDecorationtheme = InputDecorationTheme(
      errorMaxLines: 3,
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
      hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(width: 2, color: Colors.orange)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.white12),
      ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Rx variable to hold the current theme mode
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Function to set the theme mode
  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;

    print("Theme mode in controller is : ${themeMode.value}");

    // Save the selected theme mode in your preferred storage (e.g., SharedPreferences)
    // You can add the necessary code to save the theme mode based on your storage solution.
  }
}

import 'package:collegemitra/firebase_options.dart';
import 'package:collegemitra/src/features/authentication/controllers/otp_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  await Supabase.initialize(
    url: 'https://kclsmsgznxxrnboeopjw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtjbHNtc2d6bnh4cm5ib2VvcGp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE2NTk3NjQsImV4cCI6MjAxNzIzNTc2NH0.NrAXP7QCpSDuFbxjf3uhq0vZSedKrGjSZ6D1hJsP7dY',
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      highContrastTheme: TAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      useInheritedMediaQuery: true,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

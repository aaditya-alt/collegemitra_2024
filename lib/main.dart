import 'package:collegemitra/firebase_options.dart';
import 'package:collegemitra/src/features/authentication/controllers/otp_controller.dart';
import 'package:collegemitra/src/features/authentication/models/blog_section_model.dart';
import 'package:collegemitra/src/features/authentication/models/testimonial_model.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/testimonials.dart';
import 'package:collegemitra/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/splash_screen/splash_screen.dart';

import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  await Hive.initFlutter();

  await Hive.openBox('headerVideoIds');
  await Hive.openBox('footerVideoIds');
  await Hive.openBox('user');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GetMaterialApp(
      highContrastTheme: TAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      useInheritedMediaQuery: true,
      home: Scaffold(
          backgroundColor: isDark ? Colors.black : Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child:
                      Image.asset('assets/images/splash_images/background.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CircularProgressIndicator(
                    backgroundColor: isDark ? Colors.black : Colors.white,
                    color: Colors.blue,
                    strokeWidth: 5,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

import 'package:eye_app/presentation/screens/home_screen/home_screen.dart';
import 'package:eye_app/presentation/screens/login_screen/login_screen.dart';
import 'package:eye_app/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:eye_app/presentation/screens/signup_screen/signup_screen.dart';
import 'package:eye_app/presentation/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(EyeApp());
}

class EyeApp extends StatelessWidget {
  const EyeApp({super.key});

  static late String token;
  static String baseUrl = 'https://f0001fc6040b.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          OnboardingScreen.id: (context) => OnboardingScreen(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
      ),
    );
  }
}

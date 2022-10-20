import 'package:sandangs/pages/home_page.dart';
import 'package:sandangs/pages/login.dart';
import 'package:sandangs/pages/splash_screen.dart';

const String splashRoute = "/Splash";
const String homeRoute = "/Home";
const String loginRoute = "/Login";

final routes = {
  splashRoute: (context) => const SplashScreen(),
  homeRoute: (context) => const HomePages(),
  loginRoute: (context) => const LoginScreen(),
};

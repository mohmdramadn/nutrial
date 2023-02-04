import 'package:flutter/material.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/screens/login/login_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/age_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/gender_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/password_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/percentage_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/second_steps_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/steps_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/third_intro_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_intro_screens/user_info_screen.dart';
import 'package:nutrial/screens/on_boarding/on_boarding_screen.dart';
import 'package:nutrial/screens/sign_up/sign_up_screen.dart';
import 'package:nutrial/screens/welcome_screen/welcome_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(), settings: settings);

      case loginRoute:
      return MaterialPageRoute(
          builder: (context) => const LoginScreen(), settings: settings);

      case signUpRoute:
      return MaterialPageRoute(
          builder: (context) => const SignUpScreen(), settings: settings);

      case onBoardingRoute:
      return MaterialPageRoute(
          builder: (context) => const OnBoardScreen(), settings: settings);

      case firstIntroRoute:
      return MaterialPageRoute(
          builder: (context) => const StepsScreen(), settings: settings);

      case secondIntroRoute:
      return MaterialPageRoute(
          builder: (context) => const SecondStepsIntroScreen(), settings: settings);

      case thirdIntroRoute:
      return MaterialPageRoute(
          builder: (context) => const ThirdIntroScreen(), settings: settings);

      case genderRoute:
      return MaterialPageRoute(
          builder: (context) => const GenderScreen(), settings: settings);

      case ageRoute:
      return MaterialPageRoute(
          builder: (context) => const AgeScreen(), settings: settings);

    case percentageRoute:
      return MaterialPageRoute(
          builder: (context) => const BodyPercentageScreen(), settings: settings);

    case userInfoRoute:
      return MaterialPageRoute(
          builder: (context) => const UserInfoScreen(), settings: settings);

    case passwordRoute:
      return MaterialPageRoute(
          builder: (context) => const PasswordScreen(), settings: settings);

    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
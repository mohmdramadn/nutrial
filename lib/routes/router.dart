import 'package:flutter/material.dart';
import 'package:nutrial/models/activites.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/screens/calculator/categories_screen.dart';
import 'package:nutrial/screens/calories/calories_screen.dart';
import 'package:nutrial/screens/cardio/cardio_screen.dart';
import 'package:nutrial/screens/cardio_exercise/cardio_exercise_screen.dart';
import 'package:nutrial/screens/home/home_screen.dart';
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
import 'package:nutrial/screens/profile/profile_screen.dart';
import 'package:nutrial/screens/sessions/sessions_screen.dart';

import 'package:nutrial/screens/sign_up/sign_up_screen.dart';
import 'package:nutrial/screens/splash/splash_screen.dart';
import 'package:nutrial/screens/welcome_screen/welcome_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(), settings: settings);

      case welcomeRoute:
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

      case profileRoute:
      return MaterialPageRoute(
          builder: (context) => const ProfileScreen(), settings: settings);

      case categoriesRoute:
      return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(), settings: settings);

      case cardioRoute:
      return MaterialPageRoute(
          builder: (context) => const CardioScreen(), settings: settings);

      case cardioExerciseRoute:
        var activity = settings.arguments as Activities;
      return MaterialPageRoute(
          builder: (context) =>  CardioExerciseScreen(activity: activity), settings: settings);

      case sessionsRoute:
      return MaterialPageRoute(
          builder: (context) => const SessionsScreen(), settings: settings);

      case homeRoute:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: settings);

    case caloriesRoute:
      return MaterialPageRoute(
          builder: (context) => const CaloriesScreen(), settings: settings);

    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}

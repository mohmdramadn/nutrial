// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `User Name`
  String get username {
    return Intl.message(
      'User Name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get socialLogin {
    return Intl.message(
      'Or continue with',
      name: 'socialLogin',
      desc: '',
      args: [],
    );
  }

  /// `ProfileMenu`
  String get profileMenu {
    return Intl.message(
      'ProfileMenu',
      name: 'profileMenu',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Change Information`
  String get changeInfo {
    return Intl.message(
      'Change Information',
      name: 'changeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calories {
    return Intl.message(
      'Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `Calories Calculator`
  String get caloriesCalculator {
    return Intl.message(
      'Calories Calculator',
      name: 'caloriesCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Next Session`
  String get nextSession {
    return Intl.message(
      'Next Session',
      name: 'nextSession',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Here are a few steps\nto start your own journey`
  String get boardOneTitle {
    return Intl.message(
      'Here are a few steps\nto start your own journey',
      name: 'boardOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do your BMR Test to define\nMuscles percentage\nWater percentage\nFat percentage`
  String get boardOneDesc {
    return Intl.message(
      'Do your BMR Test to define\nMuscles percentage\nWater percentage\nFat percentage',
      name: 'boardOneDesc',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your needed calories per day`
  String get boardTwoTitle {
    return Intl.message(
      'Calculate your needed calories per day',
      name: 'boardTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Now ..\nIts time to fill your own application for\nDaily follow up\nto reach your goal.`
  String get boardThreeTitle {
    return Intl.message(
      'Now ..\nIts time to fill your own application for\nDaily follow up\nto reach your goal.',
      name: 'boardThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose sex`
  String get genderTitle {
    return Intl.message(
      'Choose sex',
      name: 'genderTitle',
      desc: '',
      args: [],
    );
  }

  /// `FEMALE`
  String get female {
    return Intl.message(
      'FEMALE',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `MALE`
  String get male {
    return Intl.message(
      'MALE',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageTitle {
    return Intl.message(
      'Age',
      name: 'ageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your age`
  String get enterYourAge {
    return Intl.message(
      'Enter your age',
      name: 'enterYourAge',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Enter your height in CM`
  String get enterYourHeight {
    return Intl.message(
      'Enter your height in CM',
      name: 'enterYourHeight',
      desc: '',
      args: [],
    );
  }

  /// `Percentage`
  String get percentage {
    return Intl.message(
      'Percentage',
      name: 'percentage',
      desc: '',
      args: [],
    );
  }

  /// `Muscles`
  String get muscles {
    return Intl.message(
      'Muscles',
      name: 'muscles',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `Fats`
  String get fats {
    return Intl.message(
      'Fats',
      name: 'fats',
      desc: '',
      args: [],
    );
  }

  /// `Now enter your personal details..`
  String get enterPersonalDetails {
    return Intl.message(
      'Now enter your personal details..',
      name: 'enterPersonalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Last body composition`
  String get lastBodyComposition {
    return Intl.message(
      'Last body composition',
      name: 'lastBodyComposition',
      desc: '',
      args: [],
    );
  }

  /// `Fats percentage`
  String get fatsPercentage {
    return Intl.message(
      'Fats percentage',
      name: 'fatsPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Muscles percentage`
  String get musclesPercentage {
    return Intl.message(
      'Muscles percentage',
      name: 'musclesPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Water percentage`
  String get waterPercentage {
    return Intl.message(
      'Water percentage',
      name: 'waterPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `CARDIO`
  String get cardio {
    return Intl.message(
      'CARDIO',
      name: 'cardio',
      desc: '',
      args: [],
    );
  }

  /// `Item Name`
  String get itemName {
    return Intl.message(
      'Item Name',
      name: 'itemName',
      desc: '',
      args: [],
    );
  }

  /// `Item calories`
  String get itemCalories {
    return Intl.message(
      'Item calories',
      name: 'itemCalories',
      desc: '',
      args: [],
    );
  }

  /// `Item quantity`
  String get itemQuantity {
    return Intl.message(
      'Item quantity',
      name: 'itemQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get appLanguage {
    return Intl.message(
      'App language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `YESTERDAY`
  String get yesterday {
    return Intl.message(
      'YESTERDAY',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `TODAY`
  String get today {
    return Intl.message(
      'TODAY',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message(
      'Login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Please all fields required`
  String get allFieldsRequired {
    return Intl.message(
      'Please all fields required',
      name: 'allFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Calories burned/ hour based on body weight`
  String get textCardioExercise {
    return Intl.message(
      'Calories burned/ hour based on body weight',
      name: 'textCardioExercise',
      desc: '',
      args: [],
    );
  }

  /// `Please add Time and Body Weight`
  String get addTimeWeight {
    return Intl.message(
      'Please add Time and Body Weight',
      name: 'addTimeWeight',
      desc: '',
      args: [],
    );
  }

  /// `Please check your inputs again`
  String get checkInputs {
    return Intl.message(
      'Please check your inputs again',
      name: 'checkInputs',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get done {
    return Intl.message(
      'Successfully',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `My Sessions`
  String get mySessions {
    return Intl.message(
      'My Sessions',
      name: 'mySessions',
      desc: '',
      args: [],
    );
  }

  /// `My Other Sessions`
  String get myOtherSessions {
    return Intl.message(
      'My Other Sessions',
      name: 'myOtherSessions',
      desc: '',
      args: [],
    );
  }

  /// `New User`
  String get newUser {
    return Intl.message(
      'New User',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `I already have an account`
  String get alreadyHaveAccount {
    return Intl.message(
      'I already have an account',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or communicate with`
  String get commWith {
    return Intl.message(
      'Or communicate with',
      name: 'commWith',
      desc: '',
      args: [],
    );
  }

  /// `Search workout`
  String get searchWorkout {
    return Intl.message(
      'Search workout',
      name: 'searchWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Finally set your password ..`
  String get setPasswordTitle {
    return Intl.message(
      'Finally set your password ..',
      name: 'setPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter`
  String get reEnter {
    return Intl.message(
      'Re-enter',
      name: 'reEnter',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Something happened please try again later`
  String get error {
    return Intl.message(
      'Something happened please try again later',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Passwords doesn't match`
  String get passNotMatching {
    return Intl.message(
      'Passwords doesn\'t match',
      name: 'passNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `My Other Calories`
  String get myOtherCalories {
    return Intl.message(
      'My Other Calories',
      name: 'myOtherCalories',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Last Body Composition`
  String get lastBodyComp {
    return Intl.message(
      'Last Body Composition',
      name: 'lastBodyComp',
      desc: '',
      args: [],
    );
  }

  /// `Total weight`
  String get totalWeight {
    return Intl.message(
      'Total weight',
      name: 'totalWeight',
      desc: '',
      args: [],
    );
  }

  /// `Pop-up Notifications`
  String get popUpNotification {
    return Intl.message(
      'Pop-up Notifications',
      name: 'popUpNotification',
      desc: '',
      args: [],
    );
  }

  /// `Invite a friend`
  String get inviteFriend {
    return Intl.message(
      'Invite a friend',
      name: 'inviteFriend',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Cal`
  String get cal {
    return Intl.message(
      'Cal',
      name: 'cal',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get min {
    return Intl.message(
      'Minutes',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Choose Item`
  String get chooseItem {
    return Intl.message(
      'Choose Item',
      name: 'chooseItem',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get shareApp {
    return Intl.message(
      'Share App',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

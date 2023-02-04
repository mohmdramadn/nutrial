import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('ar');

  Locale get appLocal => _appLocale;
  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') == null) {
      _appLocale = Locale(window.locale.languageCode);
      return _appLocale;
    }

    _appLocale = Locale(prefs.getString('language_code')!);
    return _appLocale;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', type.languageCode);

    _appLocale = Locale(type.languageCode);

    Get.updateLocale(_appLocale);

    notifyListeners();
  }
}
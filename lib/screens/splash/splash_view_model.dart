import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/helper/shared_prefrence.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/firebase_service.dart';

class SplashViewModel extends ChangeNotifier {
  final FirebaseService firebaseService;

  SplashViewModel({required this.firebaseService});

  void checkIsLoggedInAction() async {
    var loggedIn = firebaseService.checkIfLoggedIn();
    var user = firebaseService.getCurrentUserInfo();
    var localUser = await Preference.instance.getData(PreferenceStrings.user);

    if (!loggedIn && (localUser != user) || (user == null || localUser == null)) {
      Get.toNamed(welcomeRoute);
      return;
    }
    Get.toNamed(homeRoute);
  }
}

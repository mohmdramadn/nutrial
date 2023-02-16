import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/screens/cardio/cardio_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CategoriesViewModel extends ChangeNotifier {
  void navigateToExercise() {
    PersistentNavBarNavigator.pushNewScreen(
      Get.context!,
      screen: const CardioScreen(),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/routes_names.dart';

class CategoriesViewModel extends ChangeNotifier {
  void navigateToExercise({required String screen}) {
    if (screen == S.of(Get.context!).cardio) {
      Get.toNamed(cardioRoute);
    }

    if (screen == S.of(Get.context!).calories) {
      Get.toNamed(caloriesRoute);
    }

    if (screen == S.of(Get.context!).water) {
      Get.toNamed(cardioRoute);
    }
  }
}

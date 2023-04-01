import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/routes/routes_names.dart';

class CardioViewModel extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();
  List<String> cardioList = [
    'Cycling, mountain bike, bmx',
    'Cycling, <10 mph, leisure bicycling',
    'Cycling, >20 mph, racing',
    'Cycling, 10-11.9 mph, light',
  ];

  void navigateAction(String activity){
    Get.toNamed(cardioExerciseRoute,arguments: activity);
  }
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/helper/calories_database.dart';
import 'package:nutrial/models/activites.dart';
import 'package:nutrial/routes/routes_names.dart';

class CardioViewModel extends ChangeNotifier {
  void initAsync() {
    _cardioList = LocalDatabase.instance.activities;
    setLoadingState(false);
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();
  List<Activities> _cardioList = [];
  List<Activities> get cardioList => _cardioList;

  void navigateAction(String activity) {
    Get.toNamed(cardioExerciseRoute, arguments: activity);
  }
}

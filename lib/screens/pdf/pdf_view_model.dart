import 'package:flutter/cupertino.dart';
import 'package:nutrial/helper/calories_database.dart';
import 'package:nutrial/models/food.dart';

class PdfViewModel extends ChangeNotifier {

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  List<Food> _proteinCalories = [];
  List<Food> get proteinCalories => _proteinCalories;

  List<Food> _carbsCalories = [];
  List<Food> get carbsCalories => _carbsCalories;

  Future<void> getCaloriesAsync() async {
    _proteinCalories = CaloriesDatabase.instance.proteinCalories;
    _carbsCalories = CaloriesDatabase.instance.carbsCalories;
    setLoadingState(false);
    notifyListeners();
  }
}

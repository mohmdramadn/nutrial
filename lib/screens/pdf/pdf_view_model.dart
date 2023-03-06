import 'package:flutter/cupertino.dart';
import 'package:nutrial/helper/calories_database.dart';
import 'package:nutrial/models/cal_model.dart';

class PdfViewModel extends ChangeNotifier {

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  List<Calories> _proteinCalories = [];
  List<Calories> get proteinCalories => _proteinCalories;

  List<Calories> _carbsCalories = [];
  List<Calories> get carbsCalories => _carbsCalories;

  Future<void> getCaloriesAsync() async {
    _proteinCalories = CaloriesDatabase.instance.proteinCalories;
    _carbsCalories = CaloriesDatabase.instance.carbsCalories;
    setLoadingState(false);
    notifyListeners();
  }
}

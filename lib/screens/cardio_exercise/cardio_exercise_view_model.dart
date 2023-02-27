import 'package:flutter/cupertino.dart';
import 'package:nutrial/constants/constant_strings.dart';

class CardioExerciseViewModel extends ChangeNotifier{
  TextEditingController minutesController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  void setSuccessState(value){
    _isSuccess = value;
    notifyListeners();
  }

  String? _selectedWeight = Kilograms.sixty;
  String? get selectedWeight => _selectedWeight;
  void setSelectedWeight(String weight){
    _selectedWeight = weight;
    onMinutesChangedAction(minutesController.text);
    notifyListeners();
  }

  Map<int, String> weightCaloriesMap = {
    60:Calories.twoHundredAndThirtySix,
    70:Calories.fiveHundredAndNinetyEight,
    80:Calories.sixHundredAndNinetyFive,
    90:Calories.sevenHundredAndNinetyOne,
  };

  String? _totalCalories;
  String? get totalCalories => _totalCalories;

  void onMinutesChangedAction(String minutes) {
    if (minutesController.text == '' || minutes == '') return;
    var minutesInt = int.tryParse(minutes.replaceAll(RegExp(r'[^0-9]'), ''));
    var weight =
        int.tryParse(_selectedWeight!.replaceAll(RegExp(r'[^0-9]'), ''));
    var caloriesValue = weightCaloriesMap.entries
        .firstWhere((entry) => entry.key == weight)
        .value.replaceAll(RegExp(r'[^0-9]'), '');
    var calories = int.tryParse(caloriesValue);
    _totalCalories =
        ((minutesInt! * calories!) / minutesInt).round().toString();
    notifyListeners();
  }
}
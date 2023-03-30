import 'package:flutter/cupertino.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class CardioExerciseViewModel extends ChangeNotifier{
  final ConnectionService connectionService;
  final MessageService messageService;
  final FirebaseService firebaseService;
  final S localization;
  final String activity;

  CardioExerciseViewModel({
    required this.connectionService,
    required this.messageService,
    required this.firebaseService,
    required this.localization,
    required this.activity,
  });

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

  String? _minutes;
  String? get minutes => _minutes;

  void onMinutesChangedAction(String minutes) {
    if (minutesController.text == '' || minutes == '') return;
    _minutes = minutes;
    var minutesInt = int.tryParse(minutes.replaceAll(RegExp(r'[^0-9]'), ''));
    var weight =
        int.tryParse(_selectedWeight!.replaceAll(RegExp(r'[^0-9]'), ''));
    var caloriesValue = weightCaloriesMap.entries
        .firstWhere((entry) => entry.key == weight)
        .value.replaceAll(RegExp(r'[^0-9]'), '');
    var calories = int.tryParse(caloriesValue);
    _totalCalories =
        ((minutesInt! * calories!) / 60).round().toString();
    notifyListeners();
  }

  Future<void> saveSessionActivityActionAsync()async{
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
    }
    var response = await firebaseService.saveSessionsAsync(
      activityName: activity,
      minutes: _minutes ?? '',
      weight: _selectedWeight!,
      calories: _totalCalories!,
    );

    if (response.isError) {
      messageService.showErrorSnackBar(
          localization.error, localization.error);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    setLoadingState(false);
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';

class CardioExerciseViewModel extends ChangeNotifier{
  TextEditingController minutesController = TextEditingController();
  TextEditingController weightController = TextEditingController();

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
}
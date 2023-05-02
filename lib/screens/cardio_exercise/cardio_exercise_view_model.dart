import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/activites.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class CardioExerciseViewModel extends ChangeNotifier{
  final ConnectionService connectionService;
  final MessageService messageService;
  final FirebaseService firebaseService;
  final S localization;
  final Activities activity;

  CardioExerciseViewModel({
    required this.connectionService,
    required this.messageService,
    required this.firebaseService,
    required this.localization,
    required this.activity,
  });

  TextEditingController minutesController = TextEditingController();

  bool get isLoggedIn => firebaseService.checkIfLoggedIn();

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
    Future.delayed(const Duration(seconds: 3),(){
      Get.back();
      Get.back();
    });
    notifyListeners();
  }

  String? _selectedWeight = Kilograms.sixty;
  String? get selectedWeight => _selectedWeight;
  void setSelectedWeight(String weight){
    _selectedWeight = weight;
    onMinutesChangedAction(minutesController.text);
    notifyListeners();
  }

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
    var calories = _getSelectedKilograms(weight!);
    _totalCalories =
        ((minutesInt! * calories) / 60).round().toString();
    notifyListeners();
  }

  int _getSelectedKilograms(int weight){
    if(weight == 60) return activity.sixtyKilograms;
    if(weight == 70) return activity.seventyKilograms;
    if(weight == 80) return activity.eightyKilograms;
    if(weight == 90) return activity.ninetyKilograms;
    return activity.seventyKilograms;
  }

  Future<void> saveCardioActionAsync()async{
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      notifyListeners();
    }
    if (!isLoggedIn) {
      messageService.showDecisionAlertDialog(
        title: '',
        message: localization.notLoggedIn,
        confirm: localization.login,
        cancel: localization.signup,
        onConfirm: () => Get.offAllNamed(loginRoute),
        onCancel: () => Get.offAllNamed(onBoardingRoute),
      );
      setLoadingState(false);
      notifyListeners();
      return;
    }
    if(_minutes == null || _minutes == '') {
      Fluttertoast.showToast(
        msg: S.of(Get.context!).enterMinutes,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryLightColor,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
      notifyListeners();
      return;
    }
    setLoadingState(true);
    var response = await firebaseService.saveCardioAsync(
      activityName: activity.activityName,
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

    setSuccessState(true);
    setLoadingState(false);
    notifyListeners();
  }
}
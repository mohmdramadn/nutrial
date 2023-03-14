import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class LoginViewModel extends ChangeNotifier{
  final FirebaseService firebaseService;
  final MessageService messageService;
  final S localization;


  LoginViewModel({
    required this.firebaseService,
    required this.messageService,
    required this.localization,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginAsync()async{
    setLoadingState(true);

    var loginResponse = await firebaseService.loginAsync(
        nameController.text, passwordController.text);
    if(loginResponse.isError){
      setLoadingState(false);
      messageService.showErrorSnackBar(
          '', loginResponse.asError!.error.toString());
      return;
    }

    setLoadingState(false);
    notifyListeners();
    Get.offAllNamed(homeRoute);
  }
  Future<void> loginWithAppleAsync()async{}
  Future<void> loginWithFacebookAsync()async{}
  Future<void> loginWithSnapchatAsync()async{}
  void skipAction(){
    Get.toNamed(homeRoute);
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseService firebaseService;
  final MessageService messageService;
  final S localization;

  SignUpViewModel({
    required this.firebaseService,
    required this.messageService,
    required this.localization,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUpAsync() async {
    setLoadingState(true);
    var signUpResponse = await firebaseService.signupNewUserAsync(
        nameController.text, passwordController.text);
    if (signUpResponse.isError) {
      setLoadingState(false);
      messageService.showErrorSnackBar(
          '', signUpResponse.asError!.error.toString());
      return;
    }
    setLoadingState(false);
    Get.toNamed(homeRoute);
    notifyListeners();
  }

  Future<void> _loginAsync() async {}

  Future<void> appleSignUpAsync() async {}

  Future<void> facebookSignUpAsync() async {}

  Future<void> snapchatSignUpAsync() async {}

  void skipAction() {
    Get.toNamed(homeRoute);
  }
}
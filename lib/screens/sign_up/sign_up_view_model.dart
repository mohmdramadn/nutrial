import 'package:flutter/cupertino.dart';

class SignUpViewModel extends ChangeNotifier{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUpAsync()async{}
  Future<void> _loginAsync()async{}
  Future<void> appleSignUpAsync()async{}
  Future<void> facebookSignUpAsync()async{}
  Future<void> snapchatSignUpAsync()async{}
  void skipAction()async{}
}
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginAsync()async{}
  Future<void> loginWithAppleAsync()async{}
  Future<void> loginWithFacebookAsync()async{}
  Future<void> loginWithSnapchatAsync()async{}
  void skipAction()async{}
}
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier{
  bool _showProfileMenu = false;
  bool get showProfileMenu => _showProfileMenu;
  void setShowProfileMenuState(){
    _showProfileMenu = !_showProfileMenu;
    notifyListeners();
  }
}
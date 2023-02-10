import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier{
  bool _showProfileMenu = false;
  bool get showProfileMenu => _showProfileMenu;
  void setShowProfileMenuState(){
    _showProfileMenu = !_showProfileMenu;
    notifyListeners();
  }
}
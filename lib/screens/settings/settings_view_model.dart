import 'package:flutter/cupertino.dart';

class SettingsViewModel extends ChangeNotifier{
  bool _showQrCode = false;
  bool get showQrCode => _showQrCode;
  void setShowQrCodeState(){
    _showQrCode = !_showQrCode;
    notifyListeners();
  }
}
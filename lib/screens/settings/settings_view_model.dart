import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/services/app_language.dart';

class SettingsViewModel extends ChangeNotifier{
  final AppLanguage language;

  SettingsViewModel({required this.language});

  bool _showQrCode = false;
  bool get showQrCode => _showQrCode;
  void setShowQrCodeState(){
    _showQrCode = !_showQrCode;
    notifyListeners();
  }

  bool _isEnglish = false;
  bool get isEnglish => _isEnglish;
  void setLanguageState(value){
    _isEnglish = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> onLanguageChangedActionAsync()async{
    setLoadingState(true);
    var currentLang = await language.fetchLocale();
    if(currentLang == const Locale('en')) {
      Get.updateLocale(const Locale('ar'));
      language.changeLanguage(const Locale('ar'));
      setLanguageState(false);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    Get.updateLocale(const Locale('en'));
    language.changeLanguage(const Locale('en'));
    setLanguageState(true);
    setLoadingState(false);
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/helper/shared_prefrence.dart';
import 'package:nutrial/models/profile_model.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/app_language.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseService firebaseService;
  final MessageService messageService;
  final ConnectionService connectionService;
  final AppLanguage language;

  ProfileViewModel({
    required this.firebaseService,
    required this.messageService,
    required this.connectionService,
    required this.language,
  });

  UserProfileModel? _user;
  UserProfileModel? get user => _user;

  Future<void> initGetProfileAsync() async {
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
      return;
    }

    if (!isLoggedIn) {
      setLoadingState(false);
      return;
    }
    var response = await firebaseService.getUserProfile();
    if (response.isError) {
      messageService.showErrorSnackBar('', response.asError!.error.toString());
      setLoadingState(false);
      notifyListeners();
      return;
    }

    _user = response.asValue!.value;
    setLoadingState(false);
    notifyListeners();
  }

  bool _showProfileMenu = false;
  bool get showProfileMenu => _showProfileMenu;
  void setShowProfileMenuState() {
    _showProfileMenu = !_showProfileMenu;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoggedIn => firebaseService.checkIfLoggedIn();

  Future<void> logoutActionAsync() async {
    if (!isLoggedIn) return;
    await firebaseService.logoutAsync();
    Preference.instance.clearAll();
    Get.offAndToNamed(loginRoute);
  }

  void navigateToLogin(){
    Get.toNamed(loginRoute);
  }

  bool get isArabic => Get.locale == const Locale('ar');
}
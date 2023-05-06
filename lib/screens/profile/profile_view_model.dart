import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/extensions/date_time_extension.dart';
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
      _isLoggedIn = false;
      setLoadingState(false);
      notifyListeners();
      return;
    }

    _user = response.asValue!.value;
    _calculateNextSession();
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

  bool _isLoggedIn = true;
  bool get isLoggedIn {
    if (firebaseService.checkIfLoggedIn() && _isLoggedIn) {
      return _isLoggedIn = true;
    }
    return _isLoggedIn = false;
  }

  Future<void> logoutActionAsync() async {
    if (!isLoggedIn) return;
    await firebaseService.logoutAsync();
    Preference.instance.clearAll();
    Get.offAndToNamed(welcomeRoute);
  }

  void navigateToLogin(){
    Get.offAndToNamed(welcomeRoute);
  }

  bool get isArabic => Get.locale == const Locale('ar');

  void _calculateNextSession() {
    var isStartNewSession = _user?.nextSession == DateTime.now().dateOnly();
    if (!isStartNewSession) return;

    _user?.nextSession ==
        DateTime.now().add(const Duration(days: 7)).dateOnly();
    _updateNextSession();

    notifyListeners();
  }

  Future<void> _updateNextSession()async{
    var isConnected = await connectionService.checkConnection();
    if(!isConnected) return;

    var response = await firebaseService.updateNextSessionAsync(
        nextSession: _user!.nextSession!);
    if (response.isError) return;

  }
}
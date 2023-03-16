import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/helper/shared_prefrence.dart';
import 'package:nutrial/models/profile_model.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseService firebaseService;
  final MessageService messageService;

  ProfileViewModel({
    required this.firebaseService,
    required this.messageService,
  });

  UserProfileModel? _user;
  UserProfileModel? get user => _user;

  Future<void> initGetProfileAsync() async {
    setLoadingState(true);
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
    var response = await firebaseService.logoutAsync();
    if (response.isError) log('unable to logout');
    _user = UserProfileModel();
    Preference.instance
        .saveData(PreferenceStrings.userProfile, _user);
    Get.offAndToNamed(loginRoute);
  }
}
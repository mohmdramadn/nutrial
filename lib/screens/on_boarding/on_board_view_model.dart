import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/helper/shared_prefrence.dart';
import 'package:nutrial/models/profile_model.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class OnBoardViewModel extends ChangeNotifier{
  final FirebaseService firebaseService;
  final MessageService messageService;
  final ConnectionService connectionService;
  final S localization;

  OnBoardViewModel({
    required this.firebaseService,
    required this.messageService,
    required this.connectionService,
    required this.localization,
  });

  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController musclesController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  UserProfileModel userProfileModel = UserProfileModel();

  int currentBoard = 0;
  void setCurrentBoardState(value){
    currentBoard = value;
    notifyListeners();
  }

  int _gender = -1;
  int get gender => _gender;
  void setGender(value){
    _gender = value;
    notifyListeners();
  }

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  void setShowPassState(){
    _showPassword = !_showPassword;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  bool get _checkPasswordsMatching =>
      passwordController.text == confirmPassController.text;

  Future<void> onDoneProfileDataEntryAction()async{
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      setLoadingState(false);
      notifyListeners();
    }
    if(!_checkPasswordsMatching) {
      setLoadingState(false);
      messageService.showErrorSnackBar('', localization.passNotMatching);
      return;
    }

    _createProfileModel();

    var signUpResponse = await firebaseService.signupNewUserAsync(
        emailController.text, passwordController.text);
    if(signUpResponse.isError){
      setLoadingState(false);
      messageService.showErrorSnackBar(
          '', signUpResponse.asError!.error.toString());
      return;
    }

    await _createProfileAsync();
  }

  Future<void> _createProfileAsync() async {
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
    }
    var response =
        await firebaseService.createProfileAsync(model: userProfileModel);

    if (response.isError) {
      messageService.showErrorSnackBar(
          S.of(Get.context!).error, S.of(Get.context!).error);
      setLoadingState(false);
      notifyListeners();
      return;
    }
    userProfileModel.uid = response.asValue!.value;
    Preference.instance
        .saveData(PreferenceStrings.userProfile, userProfileModel);

    setLoadingState(false);
    notifyListeners();
    Get.offAllNamed(homeRoute);
  }

  void _createProfileModel(){
    userProfileModel.fullName = nameController.text;
    userProfileModel.username = idController.text;
    userProfileModel.password = passwordController.text;
    userProfileModel.email = emailController.text;
    userProfileModel.musclesPercentage = musclesController.text;
    userProfileModel.waterPercentage = waterController.text;
    userProfileModel.fatsPercentage = fatsController.text;
    userProfileModel.age = ageController.text;
    userProfileModel.height = heightController.text;
    userProfileModel.gender =
    _gender == 1 ? localization.male : localization.female;
  }

}
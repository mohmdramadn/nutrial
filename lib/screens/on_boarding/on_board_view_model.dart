import 'package:flutter/cupertino.dart';
import 'package:nutrial/models/profile_model.dart';

class OnBoardViewModel extends ChangeNotifier{

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

  void onDoneProfileDataEntryAction(){
    userProfileModel.fullName = nameController.text;
    userProfileModel.username = idController.text;
    userProfileModel.password = passwordController.text;
    userProfileModel.email = emailController.text;
    userProfileModel.musclesPercentage = musclesController.text;
    userProfileModel.waterPercentage = waterController.text;
    userProfileModel.fatsPercentage = fatsController.text;
    userProfileModel.age = ageController.text;
    userProfileModel.sex = _gender == 1 && _gender != -1 ? 'Male' : 'Female';

  }

}
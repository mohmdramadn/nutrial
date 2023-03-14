import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';
import 'package:nutrial/models/profile_model.dart';

class FirebaseService extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  User? user;

  Future<Result<User>> signupNewUserAsync(String email, String password) async {
    try {
      var response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
      return Result.value(response.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.message!);
    }
  }

  Future<Result<User>> loginAsync(String email, String password) async {
    try {
      var response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = response.user;
      return Result.value(response.user!);
    } on FirebaseAuthException catch (e) {
      return Result.error(e.message!);
    }
  }

  Future<Result<bool>> addNewUserNameAsync({String? displayName}) async {
    try {
      await user?.updateDisplayName(displayName);
      return Result.value(true);
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<String>> createProfileAsync(
      {required UserProfileModel model}) async {
    final newUser = <String, dynamic>{
      'uid': user?.uid,
      'Email': user?.email,
      'Full name': model.fullName,
      'username': model.username,
      'Gender': model.gender,
      'Age': model.age,
      'Muscles Percentage': model.musclesPercentage,
      'Water Percentage': model.waterPercentage,
      'Fats Percentage': model.fatsPercentage
    };
    try {
      await database.collection('users_profile').doc(user?.uid).set(newUser);
      await addNewUserNameAsync(displayName: model.fullName);
      return Result.value(user!.uid);
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<void> getCurrentUserInfo() async {
    user = firebaseAuth.currentUser;
  }

  Future<void> updateUserDisplayName(String fullName) async {
    await firebaseAuth.currentUser?.updateDisplayName(fullName);
  }

  Future<void> updateUserPassword(String password) async {
    await firebaseAuth.currentUser?.updatePassword(password);
  }
}

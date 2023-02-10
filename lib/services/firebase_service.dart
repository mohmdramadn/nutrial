import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:async/async.dart';

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

  Future<Result<void>> addNewUserNameAsync({String? displayName}) async {
    try {
      var displayNameResponse = await user?.updateDisplayName(displayName);
      return Result.value(displayNameResponse);
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> createProfileAsync({
    required String gender,
    required int age,
    required String musclesPercentage,
    required String waterPercentage,
    required String fatsPercentage,
  }) async {
    final newUser = <String, dynamic>{
      'uid': user?.uid,
      'Email': user?.email,
      'Full name': user?.displayName ?? '',
      'Gender': gender,
      'Age': age,
      'Muscles Percentage': musclesPercentage,
      'Water Percentage': waterPercentage,
      'Fats Percentage': fatsPercentage
    };

    await database
        .collection('users_profile')
        .add(newUser)
        .then((DocumentReference doc) => log('$doc'))
        .onError((error, stackTrace) => log('$error'));

    return Result.value('');
  }

  Future<void> getCurrentUserInfo()async{
    user = firebaseAuth.currentUser;
  }
}

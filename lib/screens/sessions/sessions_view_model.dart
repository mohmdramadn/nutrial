import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/services/connection_service.dart';
import 'package:nutrial/services/firebase_service.dart';
import 'package:nutrial/services/message_service.dart';

class SessionsViewModel extends ChangeNotifier{
  final FirebaseService firebaseService;
  final MessageService messageService;
  final ConnectionService connectionService;
  final S localization;

  SessionsViewModel({
    required this.firebaseService,
    required this.messageService,
    required this.connectionService,
    required this.localization,
  });

  Future<void> initGetSessionsAsync()async{
    setLoadingState(true);
    var isConnected = await connectionService.checkConnection();
    if(!isConnected){
      setLoadingState(false);
      notifyListeners();
    }
    var response = await firebaseService.getUserSessions();

    if (response.isError) {
      messageService.showErrorSnackBar('', localization.error);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    _sessionsResponse = response.asValue!.value;
    _filterSessionsResponse();
    setLoadingState(false);
    notifyListeners();
  }

  Map<DateTime, List<QuerySnapshot>>? _sessionsResponse = {};
  List<QuerySnapshot>? _sessions = [];
  List<QuerySnapshot>? get sessions => _sessions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  void _filterSessionsResponse(){
    for (var e in _sessionsResponse!.entries) {
      _sessions!.add(e.value.first);
      log(e.key.toString());
      log(e.value.first.docs.first.data().toString());
    }
  }
}
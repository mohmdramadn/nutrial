import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrial/constants/constant_strings.dart';
import 'package:nutrial/extensions/date_time_extension.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/models/cardio.dart';
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
    var response = await firebaseService.getUserCardio();

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

  List<CardioActivity>? _sessions = [];
  List<CardioActivity>? get sessions => _sessions;

  List<String> _sessionsTitle =[];
  List<String> get sessionsTitle => _sessionsTitle;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  void _filterSessionsResponse() {
    for (var entry in _sessionsResponse!.entries) {
      var data = entry.value.first.docs.first.data() as Map<String, dynamic>;
      var session = CardioActivity.fromJson(data);
      _sessions!.add(session);
      _sessionsTitle.add(_setSessionTime(entry.key));
    }
  }

  String _setSessionTime(DateTime sessionDate) {
    var day = _getWeekDay(sessionDate.weekday);
    var date = '${sessionDate.day}/${sessionDate.month}/${sessionDate.year}';
    var time =
        '${sessionDate.hoursMinutes()}${_getTimeOfDay(sessionDate)}';
    return '$day, $date $time';
  }

  String _getTimeOfDay(DateTime sessionDateTime) {
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(sessionDateTime);
    return timeOfDay.period.toString().split('.')[1].toUpperCase();
  }

  String _getWeekDay(int date) {
    if (date == DateTime.monday) return WeekDays.monday;
    if (date == DateTime.tuesday) return WeekDays.tuesday;
    if (date == DateTime.wednesday) return WeekDays.wednesday;
    if (date == DateTime.thursday) return WeekDays.thursday;
    if (date == DateTime.friday) return WeekDays.friday;
    if (date == DateTime.saturday) return WeekDays.friday;
    if (date == DateTime.sunday) return WeekDays.sunday;
    return '';
  }
}
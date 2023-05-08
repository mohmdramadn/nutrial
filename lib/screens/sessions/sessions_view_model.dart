import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrial/extensions/date_time_extension.dart';
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
    var response = await firebaseService.getUserProfile();

    if (response.isError) {
      messageService.showErrorSnackBar('', localization.error);
      setLoadingState(false);
      notifyListeners();
      return;
    }

    _nextSession = response.asValue!.value.nextSession;
    _formatSession();
    setLoadingState(false);
    notifyListeners();
  }

  String? _nextSession;
  String? get nextSession => _nextSession;

  List<String>? _sessions = [];
  List<String>? get sessions => _sessions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(value){
    _isLoading = value;
    notifyListeners();
  }

  void _formatSession() {
    var today = DateTime.now().dateOnlyNotString();
    var nextSession = DateFormat('dd/MM/yyyy').parse(_nextSession!);
    var isNextWeekSession = today.isAfter(nextSession);
    var isTodayStartOfNextSession = nextSession == today;

    if (!isNextWeekSession && !isTodayStartOfNextSession) {
      var currentSession = nextSession.subtract(const Duration(days: 7));
      _sessions!
          .add('${currentSession.weekDay()}, ${currentSession.dateOnly()}');
      return;
    }
    var pastSession = nextSession.subtract(const Duration(days: 7));

    var diffBetweenTodayAndOldNextSession =
        DateTime.now().difference(nextSession);
    var currentSession =
        DateTime.now().subtract(diffBetweenTodayAndOldNextSession);

    _sessions!.add('${currentSession.weekDay()}, ${currentSession.dateOnly()}');
    _sessions!.add('${pastSession.weekDay()}, ${pastSession.dateOnly()}');
  }
}
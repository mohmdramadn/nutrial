import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionService extends ChangeNotifier{
  Future<bool> checkConnection() {
    return InternetConnectionChecker().hasConnection;
  }
}
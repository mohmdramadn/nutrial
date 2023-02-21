import 'package:flutter/cupertino.dart';

class CardioViewModel extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();
  List<String> cardioList = [
    'Cycling, mountain bike, bmx',
    'Cycling, <10 mph, leisure bicycling',
    'Cycling, >20 mph, racing',
    'Cycling, 10-11.9 mph, light',
  ];
}
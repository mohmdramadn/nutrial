import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutrial/models/cal_model.dart';

class CaloriesDatabase {
  CaloriesDatabase._privateConstructor();
  static final CaloriesDatabase _instance = CaloriesDatabase._privateConstructor();
  static CaloriesDatabase get instance => _instance;

  final List<Calories> _proteinCalories = [];
  List<Calories> get proteinCalories => _proteinCalories;

  final List<Calories> _carbsCalories = [];
  List<Calories> get carbsCalories => _carbsCalories;

  Future<String> _loadJsonData(String jsonFile) async {
    return await rootBundle.loadString(jsonFile);
  }

  Future<void> getProteinCaloriesData() async {
    final jsonData =
    jsonDecode(await _loadJsonData('assets/json/protein_calories.json'));
    for (var item in jsonData) {
      item = Calories.fromJson(item);
      _proteinCalories.add(item);
    }
  }

  Future<void> getCarbsFatsCaloriesData() async {
    final jsonData =
    jsonDecode(await _loadJsonData('assets/json/carbs_fats_calories.json'));
    for (var item in jsonData) {
      item = Calories.fromJson(item);
      _carbsCalories.add(item);
    }
  }
}
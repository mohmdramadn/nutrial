import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutrial/models/food.dart';

class CaloriesDatabase {
  CaloriesDatabase._privateConstructor();
  static final CaloriesDatabase _instance = CaloriesDatabase._privateConstructor();
  static CaloriesDatabase get instance => _instance;

  final List<Food> _proteinCalories = [];
  List<Food> get proteinCalories => _proteinCalories;

  final List<Food> _carbsCalories = [];
  List<Food> get carbsCalories => _carbsCalories;

  Future<String> _loadJsonData(String jsonFile) async {
    return await rootBundle.loadString(jsonFile);
  }

  Future<void> getProteinCaloriesData() async {
    final jsonData =
    jsonDecode(await _loadJsonData('assets/json/protein_calories.json'));
    for (var item in jsonData) {
      item = Food.fromJson(item);
      _proteinCalories.add(item);
    }
  }

  Future<void> getCarbsFatsCaloriesData() async {
    final jsonData =
    jsonDecode(await _loadJsonData('assets/json/carbs_fats_calories.json'));
    for (var item in jsonData) {
      item = Food.fromJson(item);
      _carbsCalories.add(item);
    }
  }
}
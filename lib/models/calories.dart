// To parse this JSON data, do
//
//     final calories = caloriesFromJson(jsonString);

import 'dart:convert';

import 'package:nutrial/models/pdf_items_model.dart';

Calories caloriesFromJson(String str) => Calories.fromJson(json.decode(str));

String caloriesToJson(Calories data) => json.encode(data.toJson());

class Calories {
  Calories({
    required this.carbs,
    required this.protein,
    required this.water,
  });

  List<CaloriesModel> carbs;
  List<CaloriesModel> protein;
  int water;

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
      carbs: List<CaloriesModel>.from(
          json["carbs"].map((x) => CaloriesModel.fromJson(x))),
      protein: List<CaloriesModel>.from(
          json["protein"].map((x) => CaloriesModel.fromJson(x))),
      water: json['water']);

  Map<String, dynamic> toJson() => {
        "carbs": List<dynamic>.from(carbs.map((x) => x.toJson())),
        "protein": List<dynamic>.from(protein.map((x) => x.toJson())),
        "water": water
      };
}


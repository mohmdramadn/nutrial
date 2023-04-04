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
  });

  List<CaloriesModel> carbs;
  List<CaloriesModel> protein;

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
    carbs: List<CaloriesModel>.from(json["carbs"].map((x) => CaloriesModel.fromJson(x))),
    protein: List<CaloriesModel>.from(json["protein"].map((x) => CaloriesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carbs": List<dynamic>.from(carbs.map((x) => x.toJson())),
    "protein": List<dynamic>.from(protein.map((x) => x.toJson())),
  };
}


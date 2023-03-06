import 'dart:convert';
const String tableProteinsCalories = 'ProteinCalories';

class CaloriesFields {
  static const String id = '_id';
  static const String foodType = 'Food type';
  static const String weight = 'Wight';
  static const String calories = 'Calories';

  static final List<String> values = [id, foodType, weight, calories];
}

// To parse this JSON data, do
//
//     final calories = caloriesFromJson(jsonString);


List<Calories> caloriesFromJson(String str) => List<Calories>.from(json.decode(str).map((x) => Calories.fromJson(x)));

String caloriesToJson(List<Calories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calories {
  Calories({
    required this.foodType,
    required this.wight,
    required this.calories,
  });

  String foodType;
  String wight;
  dynamic calories;

  Calories copyWith({
    String? foodType,
    String? wight,
    dynamic calories,
  }) =>
      Calories(
        foodType: foodType ?? this.foodType,
        wight: wight ?? this.wight,
        calories: calories ?? this.calories,
      );

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
    foodType: json["Food type"],
    wight: json["Wight"],
    calories: json["Calories"],
  );

  Map<String, dynamic> toJson() => {
    "Food type": foodType,
    "Wight": wight,
    "Calories": calories,
  };
}

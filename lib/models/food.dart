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


List<Food> caloriesFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String caloriesToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    required this.foodType,
    required this.wight,
    required this.calories,
  });

  String foodType;
  String wight;
  dynamic calories;

  Food copyWith({
    String? foodType,
    String? wight,
    dynamic calories,
  }) =>
      Food(
        foodType: foodType ?? this.foodType,
        wight: wight ?? this.wight,
        calories: calories ?? this.calories,
      );

  factory Food.fromJson(Map<String, dynamic> json) => Food(
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

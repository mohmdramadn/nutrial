import 'package:nutrial/models/food.dart';

class CaloriesModel {
  String? itemName;
  int? itemCalories;
  String? itemQuantity;
  double? totalCal;

  CaloriesModel({
    this.itemName,
    this.itemCalories,
    this.totalCal,
    this.itemQuantity,
  });

  factory CaloriesModel.fromJson(Map<String, dynamic> json) => CaloriesModel(
    itemName: json["item name"],
    itemCalories: json["item calories"],
    totalCal: json["total calories"],
    itemQuantity: json["item quantity"],
  );

  factory CaloriesModel.fromLocalJsonDatabase(Food food) => CaloriesModel(
    itemName: food.foodType,
    itemCalories: food.calories.runtimeType == int
            ? food.calories
            : int.tryParse(
                food.calories.replaceAll(RegExp(r'[^0-9]'), ''),
              ),
        totalCal: 0.0,
    itemQuantity: food.wight,
  );

  Map<String, dynamic> toJson() => {
    "item name": itemName,
    "item calories": itemCalories,
    "total calories": totalCal,
    "item quantity": itemQuantity,
  };

}

class Calories {
  String? itemName;
  int? itemCalories;
  String? itemQuantity;
  double? totalCal;

  Calories({
    this.itemName,
    this.itemCalories,
    this.totalCal,
    this.itemQuantity,
  });

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
    itemName: json["item name"],
    itemCalories: json["item calories"],
    totalCal: json["total calories"],
    itemQuantity: json["item quantity"],
  );

  Map<String, dynamic> toJson() => {
    "item name": itemName,
    "item calories": itemCalories,
    "total calories": totalCal,
    "item quantity": itemQuantity,
  };

}

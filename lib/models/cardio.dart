// To parse this JSON data, do
//
//     final sessions = sessionsFromJson(jsonString);

import 'dart:convert';

CardioActivity sessionsFromJson(String str) => CardioActivity.fromJson(json.decode(str));

String sessionsToJson(CardioActivity data) => json.encode(data.toJson());

class CardioActivity {
  CardioActivity({
    required this.calories,
    required this.minutes,
    required this.weight,
    required this.activity,
  });

  String calories;
  String minutes;
  String weight;
  String activity;

  factory CardioActivity.fromJson(Map<String, dynamic> json) => CardioActivity(
    calories: json["calories"],
    minutes: json["minutes"],
    weight: json["weight"],
    activity: json["activity"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "minutes": minutes,
    "weight": weight,
    "activity": activity,
  };
}

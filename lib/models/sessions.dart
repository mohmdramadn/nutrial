// To parse this JSON data, do
//
//     final sessions = sessionsFromJson(jsonString);

import 'dart:convert';

Sessions sessionsFromJson(String str) => Sessions.fromJson(json.decode(str));

String sessionsToJson(Sessions data) => json.encode(data.toJson());

class Sessions {
  Sessions({
    required this.calories,
    required this.minutes,
    required this.weight,
  });

  String calories;
  String minutes;
  String weight;

  factory Sessions.fromJson(Map<String, dynamic> json) => Sessions(
    calories: json["calories"],
    minutes: json["minutes"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "minutes": minutes,
    "weight": weight,
  };
}

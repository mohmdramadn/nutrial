// To parse this JSON data, do
//
//     final activities = activitiesFromJson(jsonString);

import 'dart:convert';

Activities activitiesFromJson(String str) => Activities.fromJson(json.decode(str));

String activitiesToJson(Activities data) => json.encode(data.toJson());

class Activities {
  Activities({
    required this.activity,
  });

  String activity;

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
    activity: json["activity"],
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
  };
}

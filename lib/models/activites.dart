// To parse this JSON data, do
//
//     final activities = activitiesFromJson(jsonString);

import 'dart:convert';

List<Activities> activitiesFromJson(String str) => List<Activities>.from(json.decode(str).map((x) => Activities.fromJson(x)));

String activitiesToJson(List<Activities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activities {
  Activities({
    required this.activityName,
    required this.sixtyKilograms,
    required this.seventyKilograms,
    required this.eightyKilograms,
    required this.ninetyKilograms,
  });

  String activityName;
  int sixtyKilograms;
  int seventyKilograms;
  int eightyKilograms;
  int ninetyKilograms;

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
    activityName: json["Activity"],
    sixtyKilograms: json["sixty kilograms"],
    seventyKilograms: json["seventy kilograms"],
    eightyKilograms: json["eighty kilograms"],
    ninetyKilograms: json["ninety kilograms"],
  );

  Map<String, dynamic> toJson() => {
    "Activity": activityName,
    "sixty kilograms": sixtyKilograms,
    "seventy kilograms": seventyKilograms,
    "eighty kilograms": eightyKilograms,
    "ninety kilograms": ninetyKilograms,
  };
}

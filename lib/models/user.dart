// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User({
    @required this.fullName,
    @required this.profileImagePath,
    @required this.habits,
    @required this.donations,
    @required this.badHabitRecords,
  });

  final String fullName;
  final String profileImagePath;
  final List<Habit> habits;
  final List<Donation> donations;
  final List<BadHabitRecord> badHabitRecords;

  User copyWith({
    String fullName,
    String profileImagePath,
    List<Habit> habits,
    List<Donation> donations,
    List<BadHabitRecord> badHabitRecords,
  }) =>
      User(
        fullName: fullName ?? this.fullName,
        profileImagePath: profileImagePath ?? this.profileImagePath,
        habits: habits ?? this.habits,
        donations: donations ?? this.donations,
        badHabitRecords: badHabitRecords ?? this.badHabitRecords,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"] == null ? null : json["fullName"],
        profileImagePath:
            json["profileImagePath"] == null ? null : json["profileImagePath"],
        habits: json["habits"] == null
            ? null
            : List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
        donations: json["donations"] == null
            ? null
            : List<Donation>.from(
                json["donations"].map((x) => Donation.fromJson(x))),
        badHabitRecords: json["badHabitRecords"] == null
            ? null
            : List<BadHabitRecord>.from(
                json["badHabitRecords"].map((x) => BadHabitRecord.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName == null ? null : fullName,
        "profileImagePath": profileImagePath == null ? null : profileImagePath,
        "habits": habits == null
            ? null
            : List<dynamic>.from(habits.map((x) => x.toJson())),
        "donations": donations == null
            ? null
            : List<dynamic>.from(donations.map((x) => x.toJson())),
        "badHabitRecords": badHabitRecords == null
            ? null
            : List<dynamic>.from(badHabitRecords.map((x) => x.toJson())),
      };
}

class BadHabitRecord {
  BadHabitRecord({
    @required this.habitName,
    @required this.totalTimes,
    @required this.dateTime,
    @required this.cleared,
  });

  final String habitName;
  final int totalTimes;
  final DateTime dateTime;
  final bool cleared;

  BadHabitRecord copyWith({
    String habitName,
    int totalTimes,
    DateTime dateTime,
    bool cleared,
  }) =>
      BadHabitRecord(
        habitName: habitName ?? this.habitName,
        totalTimes: totalTimes ?? this.totalTimes,
        dateTime: dateTime ?? this.dateTime,
        cleared: cleared ?? this.cleared,
      );

  factory BadHabitRecord.fromRawJson(String str) =>
      BadHabitRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BadHabitRecord.fromJson(Map<String, dynamic> json) => BadHabitRecord(
        habitName: json["habitName"] == null ? null : json["habitName"],
        totalTimes: json["totalTimes"] == null ? null : json["totalTimes"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        cleared: json["cleared"] == null ? null : json["cleared"],
      );

  Map<String, dynamic> toJson() => {
        "habitName": habitName == null ? null : habitName,
        "totalTimes": totalTimes == null ? null : totalTimes,
        "dateTime": dateTime == null ? null : dateTime.toIso8601String(),
        "cleared": cleared == null ? null : cleared,
      };
}

class Donation {
  Donation({
    @required this.dateTime,
    @required this.amount,
  });

  final DateTime dateTime;
  final double amount;

  Donation copyWith({
    DateTime dateTime,
    double amount,
  }) =>
      Donation(
        dateTime: dateTime ?? this.dateTime,
        amount: amount ?? this.amount,
      );

  factory Donation.fromRawJson(String str) =>
      Donation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime == null ? null : dateTime.toIso8601String(),
        "amount": amount == null ? null : amount,
      };
}

class Habit {
  Habit({
    @required this.name,
    @required this.amount,
  });

  final String name;
  final double amount;

  Habit copyWith({
    String name,
    double amount,
  }) =>
      Habit(
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );

  factory Habit.fromRawJson(String str) => Habit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
      };
}

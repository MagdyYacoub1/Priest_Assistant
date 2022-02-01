import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:priest_assistant/entities/note.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:priest_assistant/entities/settings.dart';

part 'confessor.g.dart';

@HiveType(typeId: 0)
class Confessor extends HiveObject {
  @HiveField(0)
  Uint8List? photo;
  @HiveField(1)
  String fName;
  @HiveField(2)
  String lName;
  @HiveField(3)
  List<Note> notes;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String countryCode;
  @HiveField(6)
  String? address;
  @HiveField(7)
  DateTime lastConfessDate;
  @HiveField(8)
  String? email;

  Confessor({
    this.photo,
    required this.fName,
    required this.lName,
    required this.notes,
    required this.phone,
    required this.countryCode,
    this.address,
    required this.lastConfessDate,
    this.email,
  });

  @override
  String toString() {
    return 'Confessor{fName: $fName, lName: $lName, notes: $notes, phone: $phone, countryCode: $countryCode, address: $address, lastConfessDate: $lastConfessDate, email: $email}';
  }

  String getDate(Locale locale) {
    String formatted = DateFormat.yMd(locale.toString()).format(this.lastConfessDate);
    return formatted;
  }

  bool isLate() {
    bool late = false;
    DateTime dateToday = new DateTime.now();
    if ((dateToday.difference(this.lastConfessDate).inHours / 24).round() >=
        (Settings.lateMonthsNumber * 30)) {
      late = true;
    }
    return late;
  }

  int lateMonths() {
    DateTime dateToday = new DateTime.now();
    double temp = dateToday.difference(this.lastConfessDate).inDays / (Settings.lateMonthsNumber * 30);
    int months = temp.toInt();
    return months;
  }
}

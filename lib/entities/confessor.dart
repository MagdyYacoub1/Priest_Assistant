import 'dart:typed_data';
import 'package:priest_assistant/entities/note.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'confessor.g.dart';

@HiveType(typeId: 0)
class Confessor extends HiveObject {
  @HiveField(0)
  Uint8List photo;
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
  String address;
  @HiveField(7)
  DateTime lastConfessDate;
  @HiveField(8)
  String email;

  Confessor({
    this.photo,
    this.fName,
    this.lName,
    this.notes,
    this.phone,
    this.countryCode,
    this.address,
    this.lastConfessDate,
    this.email,
  });

  @override
  String toString() {
    return 'Confessor{fName: $fName, lName: $lName, notes: $notes, phone: $phone, countryCode: $countryCode, address: $address, lastConfessDate: $lastConfessDate, email: $email}';
  }

  String getDate() {
    String formatted = DateFormat.yMd().format(this.lastConfessDate);
    return formatted;
  }

  bool isLate() {
    bool late = false;
    DateTime dateToday = new DateTime.now();
    if ((dateToday.difference(this.lastConfessDate).inHours / 24).round() >=
        30) {
      late = true;
    }
    return late;
  }

  int lateMonths() {
    DateTime dateToday = new DateTime.now();
    int months = dateToday.month - this.lastConfessDate.month;
    return months;
  }
}

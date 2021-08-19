import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'confessor.g.dart';

@HiveType(typeId: 0)
class Confessor {
  @HiveField(0)
  Uint8List photo;
  @HiveField(1)
  String fName;
  @HiveField(2)
  String lName;
  @HiveField(3)
  String notes;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String address;
  @HiveField(6)
  DateTime lastConfessDate;
  @HiveField(7)
  String email;

  Confessor({ this.photo, this.fName, this.lName, this.notes, this.phone,
    this.address, this.lastConfessDate, this.email});


  @override
  String toString() {
    return 'Confessor{fName: $fName, lName: $lName, notes: $notes, phone: $phone, address: $address, lastConfessDate: $lastConfessDate, email: $email}';
  }

  String getDate (){
    String formatted = DateFormat.yMd().format(this.lastConfessDate);
    return formatted;
  }
}
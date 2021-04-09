import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'confessor.g.dart';

@HiveType(typeId: 0)
class Confessor {
  @HiveField(0)
  var photo;
  @HiveField(1)
  String name;
  @HiveField(2)
  String notes;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String address;
  @HiveField(5)
  DateTime lastConfessDate;
  @HiveField(6)
  String email;

  Confessor({ this.photo,@required this.name, this.notes, this.phone,
    this.address, this.lastConfessDate});

  String getDate (){
    String formatted = DateFormat.yMd().format(this.lastConfessDate);
    return formatted;
  }
}
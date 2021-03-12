import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class Confessor {
  var photo;
  String name;
  String notes;
  String phone;
  String address;
  DateTime lastConfessDate;

  Confessor({ this.photo,@required this.name, this.notes, this.phone,
    this.address, this.lastConfessDate});

  String getDate (){
    String formatted = DateFormat.yMd().format(this.lastConfessDate);
    return formatted;
  }
}
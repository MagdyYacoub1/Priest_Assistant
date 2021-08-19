import 'package:flutter/material.dart';
import 'confessor.dart';

class ConfessorUtilities extends ChangeNotifier {
  static final List<Confessor> confessors = [];
  static final List<Confessor> lateConfessors = [];

  List<Confessor> get confessorsList => confessors;

  List<Confessor> get lateConfessorsList => lateConfessors;

  void addConfessor(Confessor newConfessor) {
    confessors.add(newConfessor);
    notifyListeners();
  }

  void filterLateConfessors(){
    lateConfessorsList.clear();
    DateTime dateToday = new DateTime.now();
    confessors.forEach((confessor) {
      if ((dateToday.difference(confessor.lastConfessDate).inHours / 24)
          .round() >= 30) {
        lateConfessors.add(confessor);
      }
    });


  }
}

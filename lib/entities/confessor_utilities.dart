import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'confessor.dart';

class ConfessorUtilities extends ChangeNotifier {
  static final List<Confessor> confessors = [];
  static final List<Confessor> lateConfessors = [];
  final confessorsBox = Hive.box("confessors");


  List<Confessor> get confessorsList => confessors;

  List<Confessor> get lateConfessorsList => lateConfessors;

  void addConfessor(Confessor newConfessor) {
    confessors.add(newConfessor);
    confessorsBox.add(newConfessor);
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

  void fetchDatabase(){
    confessorsList.clear();
    for(int i = 0; i < confessorsBox.length ; i++){
      confessorsList.add(confessorsBox.getAt(i));
    }
    //notifyListeners();
  }
}

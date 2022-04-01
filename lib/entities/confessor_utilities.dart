import 'package:hive/hive.dart';
import 'package:priest_assistant/entities/settings.dart';
import 'confessor.dart';

class ConfessorUtilities {
  static const String ConfessorsBoxName = "confessors";

  static void addConfessor(Confessor newConfessor) {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    confessorsBox.add(newConfessor);
  }

  static List<Confessor> filterLateConfessors() {
    List<Confessor> lateConfessors = [];
    DateTime dateToday = new DateTime.now();
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    for (int i = 0; i < confessorsBox.length; i++) {
      Confessor checkedConfessor = confessorsBox.getAt(i)!;
      if ((dateToday.difference(checkedConfessor.lastConfessDate).inHours / 24)
              .round() >=
          (30 * Settings.lateMonthsNumber)) {
        lateConfessors.add(checkedConfessor);
      }
    }
    return lateConfessors;
  }

  static List<Confessor> searchFilter(String query) {
    List<Confessor> results = [];
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    for (int i = 0; i < confessorsBox.length; i++) {
      Confessor checkedConfessor = confessorsBox.getAt(i)!;
      if (checkedConfessor.fName.toLowerCase().contains(query.toLowerCase()) ||
          checkedConfessor.lName.toLowerCase().contains(query.toLowerCase()) ||
          checkedConfessor.phone.toLowerCase().contains(query.toLowerCase())) {
        results.add(checkedConfessor);
      }
    }
    return results;
  }

  static Confessor? readConfessor(dynamic confessorKey) {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    return confessorsBox.get(confessorKey);
  }

  static void renewConfession(Confessor renewConfessor) async {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    await confessorsBox.put(renewConfessor.key, renewConfessor);
  }

  static void deleteConfessor(Confessor deletedConfessor) async {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    await confessorsBox.delete(deletedConfessor.key);
  }

  static void editConfessor(Confessor updatedConfessor) async {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    await confessorsBox.put(updatedConfessor.key, updatedConfessor);
  }

  static void deleteNote(int noteIndex, Confessor confessor) async {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    confessor.notes.removeAt(noteIndex);
    await confessorsBox.put(confessor.key, confessor);
  }

  static int countConfessors() {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    return confessorsBox.length;
  }

  static Iterable<Confessor> getAllConfessors() {
    Box<Confessor> confessorsBox = Hive.box<Confessor>(ConfessorsBoxName);
    return confessorsBox.values;
  }
}

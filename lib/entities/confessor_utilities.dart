import 'package:hive/hive.dart';
import 'confessor.dart';

class ConfessorUtilities {

  static void addConfessor(Confessor newConfessor) {
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    confessorsBox.add(newConfessor);
  }

  static List<Confessor> filterLateConfessors() {
    List<Confessor> lateConfessors = [];
    DateTime dateToday = new DateTime.now();
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    for (int i = 0; i < confessorsBox.length; i++) {
      Confessor checkedConfessor = confessorsBox.getAt(i);
      if ((dateToday.difference(checkedConfessor.lastConfessDate).inHours / 24)
              .round() >=
          30) {
        lateConfessors.add(checkedConfessor);
      }
    }
    return lateConfessors;
  }

  static Confessor readConfessor(dynamic confessorKey) {
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    return confessorsBox.get(confessorKey);
  }

  static void renewConfession(Confessor renewConfessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    await confessorsBox.put(renewConfessor.key, renewConfessor);
  }

  static void deleteConfessor(Confessor deletedConfessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    await confessorsBox.delete(deletedConfessor.key);
  }
  static void editConfessor(Confessor updatedConfessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    await confessorsBox.put(updatedConfessor.key, updatedConfessor);
  }

  static void deleteNote(int noteIndex, Confessor confessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    confessor.notes.removeAt(noteIndex);
    await confessorsBox.put(confessor.key, confessor);
  }
}

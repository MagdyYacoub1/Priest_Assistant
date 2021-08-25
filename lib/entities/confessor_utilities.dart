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


  static void renewConfession(Confessor renewConfessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    await confessorsBox.put(renewConfessor.key, renewConfessor);
  }

  static void deleteConfessor(Confessor deletedConfessor) async{
    Box<Confessor> confessorsBox = Hive.box<Confessor>("confessors");
    await confessorsBox.delete(deletedConfessor.key);
  }
}

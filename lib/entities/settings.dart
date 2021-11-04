import 'package:hive/hive.dart';

class Settings{
  static const String SettingsBoxName = "settings";
  static int lateMonthsNumber;
  static String lateMonthsKey = "lateMonths";


  static List<String> lateMonthsChoices = ["1 month", "2 months", "3 months"];

  static void updateLateMonths(int newValue) {
    lateMonthsNumber = newValue;
    Box settingsBox = Hive.box(SettingsBoxName);
    settingsBox.put(lateMonthsKey, lateMonthsNumber);
  }

  static int readLateMonths() {
    Box confessorsBox = Hive.box(SettingsBoxName);
    lateMonthsNumber = confessorsBox.get(lateMonthsKey, defaultValue: 1);
    return lateMonthsNumber;
  }
}
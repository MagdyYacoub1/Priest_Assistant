import 'package:hive/hive.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';

class Settings{
  static const String SettingsBoxName = "settings";
  static int lateMonthsNumber = 1;
  static String lateMonthsKey = "lateMonths";


  static List<String> lateMonthsChoices = [LocaleKeys.month1, LocaleKeys.month2, LocaleKeys.month3];

  static void updateLateMonths(int newValue) {
    Box settingsBox = Hive.box(SettingsBoxName);
    settingsBox.put(lateMonthsKey, lateMonthsNumber);
  }

  static int readLateMonths() {
    Box confessorsBox = Hive.box(SettingsBoxName);
    lateMonthsNumber = confessorsBox.get(lateMonthsKey, defaultValue: 1);
    return lateMonthsNumber;
  }
}
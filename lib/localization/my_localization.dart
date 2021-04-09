import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyLocalization extends ChangeNotifier{
  Locale locale;
  static Map<String, String> _localizedValues;

  MyLocalization.withLocal(this.locale);
  MyLocalization.withoutLocal();

  static MyLocalization of(BuildContext cont) {
    return Localizations.of<MyLocalization>(cont, MyLocalization);
  }

  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString('lib/localization/languages/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
      return _localizedValues[key];
  }

  //static
  static const LocalizationsDelegate<MyLocalization> delegate =
      _MyLocalizationDelegate();


  void setLocale(String languageCode) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString("languageCode", languageCode);
    _changeLanguage(languageCode);
    notifyListeners();
  }

  Locale _changeLanguage(String languageCode) {
    Locale _temp;
    if (languageCode == 'ar') {
      _temp = Locale(Arabic, 'EG');
    } else {
      _temp = Locale(English, 'US');
    }
    return this.locale = _temp;
  }


  Future<Locale> getLocale() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String languageCode = _pref.getString("languageCode") ?? English;
    return _changeLanguage(languageCode);
  }

}



class _MyLocalizationDelegate extends LocalizationsDelegate<MyLocalization> {
  const _MyLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => [English, Arabic].contains(locale.languageCode);

  @override
  Future<MyLocalization> load(Locale locale) async {
    MyLocalization localization = new MyLocalization.withLocal(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_MyLocalizationDelegate old) => false;
}

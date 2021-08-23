import 'package:flutter/material.dart';
import 'package:priest_assistant/translations/language.dart';

Locale pickLocale(deviceLocale, supportedLocales) {
  for (var locale in supportedLocales) {
    if (locale.languageCode == deviceLocale?.languageCode &&
        locale.countryCode == deviceLocale?.countryCode) {
      return locale;
    }
  }
  return supportedLocales.first;
}

// language Code
const String English = "en";
const String Arabic = "ar";


List<Language> languageList = [
    Language(
        id: 1,
        name: 'English',
        flag: '🇺🇸',
        languageCode: 'en',
        countryCode: 'US'),
    Language(
        id: 2,
        name: 'العربية',
        flag: '🇪🇬',
        languageCode: 'ar',
        countryCode: 'EG')
  ];


List<Locale> supportedLocales = [
  Locale(languageList[0].languageCode, languageList[0].countryCode),
// English, United States country code
   Locale(languageList[1].languageCode, languageList[1].countryCode),
// Arabic, Egypt country code
];

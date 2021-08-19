import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localization/my_localization.dart';


String getTranslated(BuildContext context, String key){
  return MyLocalization.of(context).getTranslatedValue(key);
}

Locale pickLocale(deviceLocale, supportedLocales){
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

List<Locale> supportedLocales = [
  const Locale(English, 'US'),
// English, United States country code
const Locale(Arabic, 'EG'),
// Arabic, Egypt country code
];

List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  MyLocalization.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "appBar_title": "مساعد الكاهن",
  "email": "البريد الالكتروني",
  "phone": "هاتف",
  "note": "ملحوظة",
  "priest": "الكاهن",
  "assistant": "مساعد",
  "late_status": "متأخر",
  "good_status": "جيد",
  "months_count": "الأشهر المتأخرة"
};
static const Map<String,dynamic> en = {
  "appBar_title": "Priest Assistant",
  "email": "Email",
  "phone": "Phone",
  "note": "Note",
  "priest": "Priest",
  "assistant": "Assistant",
  "late_status": "Late",
  "good_status": "Good",
  "months_count": "Late months"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}

import 'package:flutter/material.dart';
import '../localization/my_localization.dart';


String getTranslated(BuildContext context, String key){
  return MyLocalization.of(context).getTranslatedValue(key);
}


// language Code
const String English = "en";
const String Arabic = "ar";
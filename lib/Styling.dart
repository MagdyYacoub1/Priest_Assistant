import 'package:flutter/material.dart';

MaterialColor mainColor = createMaterialColor(Color(0xFF20315F));
const Color accentColor = const Color(0xFF6A7FBA);
const Color paleRed = const Color(0xFFFFCDD2);
const Color deepRed = const Color(0xFFEF5350);
const Color extensionColor = const Color(0xFFE0E0E0);



ThemeData myTheme = ThemeData(
  primarySwatch: mainColor,
  accentColor: accentColor,
);

const TextStyle logoText1TextStyle = const TextStyle(
  fontSize: 50,
  color: Colors.white,
);

const TextStyle logoText2TextStyle = const TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle phone_dateTextStyle = const TextStyle(
  fontSize: 17,
);

const TextStyle nameTextStyle = const TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);


const TextStyle appBarTextStyle = const TextStyle(
  fontSize: 25,
);

const TextStyle statusTextStyle = const TextStyle(
  color: deepRed,
  fontSize: 17,
);

const TextStyle expansionTextStyle = const TextStyle(
  fontSize: 20,
);

const TextStyle contextTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: accentColor,
);

const TextStyle ButtonTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  //color: accentColor,
);


const BoxDecoration horizontalListBoxDecoration = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.white, paleRed],
  ),
);

const BoxDecoration extension_lateBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.white, deepRed])
);







MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
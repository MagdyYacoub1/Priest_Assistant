import 'package:flutter/material.dart';

MaterialColor mainColor = createMaterialColor(Color(0xFF20315F));
const Color accentColor = const Color(0xFF6A7FBA);
const Color themeColor = const Color(0xFF20315F);
const Color paleRed = const Color(0xFFFFCDD2);
const Color deepRed = const Color(0xFFEF5350);
Color backgroundGreen = const Color(0XFF2E7D32).withOpacity(0.9);
Color backgroundRed = const Color(0XFFC62828).withOpacity(0.9);
const Color deepGreen = const Color(0xFF66BB6A);
const Color extensionColor = const Color(0xFFE0E0E0);
const Color dividerColor = const Color(0xFFBDBDBD);

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

const TextStyle redStatusTextStyle = const TextStyle(
  color: deepRed,
  height: 2,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);

const TextStyle greenStatusTextStyle = const TextStyle(
  color: deepGreen,
  height: 2,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);

const TextStyle expansionTextStyle = const TextStyle(
  fontSize: 20,
);
const TextStyle hintTextStyle = TextStyle(
  fontSize: 17.0,
  color: Colors.grey,
);

const TextStyle contextTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: accentColor,
);

const TextStyle headerTextStyle = TextStyle(
  fontSize: 23,
  fontWeight: FontWeight.bold,
  color: accentColor,
);

const TextStyle numberTextStyle = TextStyle(
  fontSize: 50,
  //fontWeight: FontWeight.bold,
  color: accentColor,
);

const TextStyle contrastTextStyle = TextStyle(
  fontSize: 20,
  //fontWeight: FontWeight.bold,
  color: Colors.white,
);

const BoxDecoration horizontalListBoxDecoration = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.white, paleRed],
  ),
);

const BoxDecoration extensionLateBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(colors: [Colors.white, deepRed]));

const BoxDecoration extensionLateBoxDecorationReversed = const BoxDecoration(
    gradient: LinearGradient(colors: [deepRed, Colors.white]));

const BoxDecoration extensionOnTimeBoxDecoration = const BoxDecoration(
    gradient: LinearGradient(colors: [Colors.white, deepGreen]));

const BoxDecoration extensionOnTimeBoxDecorationReversed = const BoxDecoration(
    gradient: LinearGradient(colors: [deepGreen, Colors.white]));

InputDecoration bottomSheetInputDecoration(String hintText) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 2.0,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: Colors.green,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: Colors.red,
      ),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 17.0,
      color: Colors.grey,
    ),
  );
}




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

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
        alpha, (red * value).round(), (green * value).round(), (blue * value).round());
  }
}

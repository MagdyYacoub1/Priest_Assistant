import 'dart:ui';

import "package:flutter/material.dart";
import 'package:priest_assistant/entities/settings.dart';
import 'package:priest_assistant/translations/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/localization_constants.dart';

import '../Styling.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/settings_page";

  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Language setLanguage(BuildContext context) {
    for (var i = 0; i < languageList.length; i++) {
      if (languageList[i].languageCode == context.locale.languageCode)
        return languageList[i];
    }
    return languageList[0];
  }

  @override
  Widget build(BuildContext context) {
    Language dropdownValue = setLanguage(context);
    double horizontalGap = 10.0;
    double leadingGap = 0.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              bottom: 5.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ListTile(
                  horizontalTitleGap: horizontalGap,
                  minLeadingWidth: leadingGap,
                  leading: Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Language",
                      style: contrastTextStyle,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dropdownValue.name,
                        style: contrastTextStyle,
                      ),
                      PopupMenuButton<int>(
                        onSelected: (value) async {
                          switch (value) {
                            case 0:
                              await context.setLocale(Locale(
                                  languageList[value].languageCode,
                                  languageList[value].countryCode));
                              break;
                            case 1:
                              await context.setLocale(Locale(
                                  languageList[value].languageCode,
                                  languageList[value].countryCode));
                              break;
                          }
                        },
                        enableFeedback: true,
                        itemBuilder: (context) => [
                          ...List.generate(
                            languageList.length,
                            (index) => PopupMenuItem(
                              value: index,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    languageList[index].flag,
                                    style: appBarTextStyle,
                                  ),
                                  Text(languageList[index].name),
                                ],
                              ),
                            ),
                          )
                        ],
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        iconSize: 30.0,
                        elevation: 10,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  horizontalTitleGap: horizontalGap,
                  minLeadingWidth: leadingGap,
                  leading: Icon(
                    Icons.access_alarm_rounded,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Late after",
                      style: contrastTextStyle,
                    ),
                  ),
                  isThreeLine: true,
                  subtitle: Text(
                    "Confessors are considered late after that period",
                    style: hintTextStyle,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        dropdownValue.name,
                        style: contrastTextStyle,
                      ),
                      PopupMenuButton<int>(
                        onSelected: (value) async {
                          switch (value) {
                            case 0:
                              Settings.lateMonthsNumber = 1;
                              break;
                            case 1:
                              Settings.lateMonthsNumber = 2;
                              break;
                            case 2:
                              Settings.lateMonthsNumber = 3;
                              break;
                          }
                        },
                        enableFeedback: true,
                        itemBuilder: (context) => [
                          ...List.generate(
                            Settings.lateMonthsChoices.length,
                            (index) => PopupMenuItem(
                              value: index,
                              child: Text(Settings.lateMonthsChoices[index]),
                            ),
                          )
                        ],
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        iconSize: 30.0,
                        elevation: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

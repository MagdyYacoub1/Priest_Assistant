import "package:flutter/material.dart";
import 'package:priest_assistant/entities/settings.dart';
import 'package:priest_assistant/screens/settings_screen/components/settings_tile.dart';
import 'package:priest_assistant/translations/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/translations/localization_constants.dart';
import 'package:priest_assistant/widgets/snackBar_widget.dart';

import '../../../styling.dart';
import 'components/section_title.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/settings_page";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String dropdownConfessionPeriod;

  void onLanguageOptionSelected(value) async {
    switch (value) {
      case 0:
        await context.setLocale(Locale(
            languageList[value].languageCode, languageList[value].countryCode));
        break;
      case 1:
        await context.setLocale(Locale(
            languageList[value].languageCode, languageList[value].countryCode));
        break;
    }
  }

  void onConfessionPeriodOptionSelected(value) async {
    switch (value) {
      case 0:
        Settings.lateMonthsNumber = 1;
        Settings.updateLateMonths(1);
        showSnackBar(context, LocaleKeys.settings_updated.tr());
        setState(() {
          dropdownConfessionPeriod =
              Settings.lateMonthsChoices[Settings.lateMonthsNumber - 1].tr();
        });
        break;
      case 1:
        Settings.lateMonthsNumber = 2;
        Settings.updateLateMonths(2);
        showSnackBar(context, LocaleKeys.settings_updated.tr());
        setState(() {
          dropdownConfessionPeriod =
              Settings.lateMonthsChoices[Settings.lateMonthsNumber - 1].tr();
        });
        break;
      case 2:
        Settings.lateMonthsNumber = 3;
        Settings.updateLateMonths(3);
        showSnackBar(context, LocaleKeys.settings_updated.tr());
        setState(() {
          dropdownConfessionPeriod =
              Settings.lateMonthsChoices[Settings.lateMonthsNumber - 1].tr();
        });
        break;
    }
  }

  Language setLanguage(BuildContext context) {
    for (var i = 0; i < languageList.length; i++) {
      if (languageList[i].languageCode == context.locale.languageCode)
        return languageList[i];
    }
    return languageList[0];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarPadding = 4.0 + mediaQuery.padding.top;
    Language dropdownLanguageValue = setLanguage(context);
    dropdownConfessionPeriod =
        Settings.lateMonthsChoices[Settings.lateMonthsNumber - 1].tr();

    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
            top: statusBarPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: AlignmentDirectional.centerStart,
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.adaptive.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SectionTitle(
                title: LocaleKeys.general_settings.tr(),
              ),
              //Language tile
              SettingsTile(
                title: LocaleKeys.language.tr(),
                icon: Icons.language,
                chosenValue: dropdownLanguageValue.name,
                onOptionSelected: onLanguageOptionSelected,
                optionsList: [
                  ...List.generate(
                    languageList.length,
                    (index) => PopupMenuItem(
                      value: index,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ),
              //confession period tile
              SettingsTile(
                title: LocaleKeys.confession_period.tr(),
                description: LocaleKeys.confession_period_hint.tr(),
                icon: Icons.access_alarm_rounded,
                chosenValue: dropdownConfessionPeriod,
                optionsList: [
                  ...List.generate(
                    Settings.lateMonthsChoices.length,
                    (index) => PopupMenuItem(
                      value: index,
                      child: Text(Settings.lateMonthsChoices[index].tr()),
                    ),
                  )
                ],
                onOptionSelected: onConfessionPeriodOptionSelected,
              )
            ],
          ),
        ),
      ),
    );
  }
}

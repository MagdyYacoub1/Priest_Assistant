import 'package:flutter/material.dart';
import '../screens/settings_screen/settings_page.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../styling.dart';
import '../screens/add_edit_screen/add_edit_page.dart';
import '../screens/statistics_screen/statistics_page.dart';

class MyDrawer extends StatelessWidget {
  void showAddForm(context) {
    Navigator.of(context).pushNamed(AddEditPage.routeName, arguments: null);
  }

  void showStatistics(context) {
    Navigator.of(context).pushNamed(StatisticsPage.routeName);
  }

  void showSettings(context) {
    Navigator.of(context).pushNamed(SettingsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  LocaleKeys.priest.tr(),
                  style: logoText1TextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  LocaleKeys.assistant.tr(),
                  style: logoText2TextStyle,
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text(LocaleKeys.add_confessor.tr()),
                onTap: () => showAddForm(context),
              ),
              ListTile(
                leading: Icon(Icons.stacked_line_chart),
                title: Text(LocaleKeys.statistics.tr()),
                onTap: () => showStatistics(context),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(LocaleKeys.settings.tr()),
                onTap: () => showSettings(context),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(LocaleKeys.profile.tr()),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title: Text(LocaleKeys.about.tr()),
                onTap: () {},
              ),
              Spacer(),
              Image.asset(
                "assets/images/brand_logo.png",
                height: size.width * 0.45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

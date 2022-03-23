import 'package:flutter/material.dart';
import 'package:priest_assistant/screens/add_edit_screen/add_page.dart';
import 'package:priest_assistant/screens/profile_screen/profile_page.dart';
import 'package:priest_assistant/screens/settings_screen/settings_page.dart';
import 'package:priest_assistant/screens/statistics_screen/statistics_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ProfilePage.routeName: (ctx) => ProfilePage(),
  AddPage.routeName: (ctx) => AddPage(),
  StatisticsPage.routeName: (ctx) => StatisticsPage(),
  SettingsPage.routeName: (ctx) => SettingsPage(),
};

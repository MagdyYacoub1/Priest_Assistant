import 'package:flutter/material.dart';
import 'package:priest_assistant/pages/add_page.dart';
import 'package:priest_assistant/pages/profile_page.dart';
import 'package:priest_assistant/pages/settings_page.dart';
import 'package:priest_assistant/pages/statistics_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
ProfilePage.routeName: (ctx) => ProfilePage(),
AddPage.routeName: (ctx) => AddPage(),
StatisticsPage.routeName: (ctx) => StatisticsPage(),
SettingsPage.routeName: (ctx) => SettingsPage(),

};
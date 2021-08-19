import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import 'package:priest_assistant/localization/my_localization.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:priest_assistant/routes.dart';
import 'package:provider/provider.dart';

import './widgets/custom_drawer.dart';
import './pages/home_page.dart';
import './entities/confessor.dart';
import 'Styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ConfessorAdapter());
  runApp(ChangeNotifierProvider(
    create: (context) => MyLocalization.withoutLocal(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MyLocalization>(context).getLocale(),
      builder: initialPageBuilder,
    );
  }
}

Widget initialPageBuilder(context, snapshot) {
  Widget homePage = SafeArea(child: CustomDrawer(child: HomePage()));
  if (snapshot.connectionState == ConnectionState.none ||
      snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
  } else if (snapshot.connectionState == ConnectionState.done) if (snapshot
      .hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    Locale fetchedLocale = snapshot.data;
    return ChangeNotifierProvider(
      create: (context) => ConfessorUtilities(),
      child: MaterialApp(
        locale: fetchedLocale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        localeResolutionCallback: pickLocale,
        home: homePage,
        theme: myTheme,
        routes: routes,
      ),
    );
  }
  else {
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:priest_assistant/translations//localization_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:priest_assistant/routes.dart';
import 'package:provider/provider.dart';
import './widgets/custom_drawer.dart';
import './pages/home_page.dart';
import './entities/confessor.dart';
import 'Styling.dart';
import 'entities/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ConfessorAdapter());
  Hive.registerAdapter(NoteAdapter());
  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: Locale(languageList[0].languageCode),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          //Hive.openBox("settings"),
          Hive.openBox("confessors"),
        ],
      ),
      initialData: Scaffold(),
      builder: (context, snapshots) {
        return initialPageBuilder(context, snapshots);
      },
    );
  }
}

Widget initialPageBuilder(
    BuildContext context, AsyncSnapshot<Object> snapshots) {
  Widget homePage = SafeArea(child: CustomDrawer(child: HomePage()));
  if (snapshots.connectionState == ConnectionState.done) {
    if (snapshots.hasError) {
      return Text('Error: ${snapshots.error}');
    } else {
      return ChangeNotifierProvider(
        create: (context) => ConfessorUtilities(),
        child: MaterialApp(
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          localeResolutionCallback: pickLocale,
          home: homePage,
          theme: myTheme,
          routes: routes,
        ),
      );
    }
  } else {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

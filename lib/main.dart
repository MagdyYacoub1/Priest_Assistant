import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import 'package:priest_assistant/localization/my_localization.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import './pages/profile_page.dart';
import './widgets/custom_drawer.dart';
import './pages/home_page.dart';
import './entities/confessor.dart';

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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Widget child = HomePage();
    child = CustomDrawer(child: child);
    return FutureBuilder(
      future: Provider.of<MyLocalization>(context).getLocale(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            //TODO: implement loading page ///
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError) {
              // Return some error widget
              return Text('Error: ${snapshot.error}');
            } else {
              Locale fetchedLocale = snapshot.data;
              return MaterialApp(
                locale: fetchedLocale,
                localizationsDelegates: [
                  // app-specific localization delegate[s] here
                  MyLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale(English, 'US'),
                  // English, United States country code
                  const Locale(Arabic, 'EG'),
                  // Arabic, Egypt country code
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (locale.languageCode == deviceLocale?.languageCode &&
                        locale.countryCode == deviceLocale?.countryCode) {
                      return locale;
                    }
                  }
                  return supportedLocales.first;
                },
                title: 'appBar_title',
                debugShowCheckedModeBanner: false,
                home: FutureBuilder(
                  future: Hive.openBox('confessors'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError)
                        //TODO: implement error page /
                        return Text(snapshot.error.toString());
                      else
                        return child;
                    }
                    // Although opening a Box takes a very short time,
                    // we still need to return something before the Future completes.
                    else
                      //TODO: implement loading page ///
                      return Scaffold();
                  },
                ),
                initialRoute: '/',
                routes: {
                  ProfilePage.routeName: (ctx) => ProfilePage(),
                },
              );
            }
            break;
          default:
            return null;
        }
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

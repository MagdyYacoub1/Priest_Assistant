import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/entities/settings.dart';
import 'package:priest_assistant/pages/add_page.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/widgets/appBar_Builder.dart';

import '../Styling.dart';
import '../widgets/tile_widget_horizontal.dart';
import '../widgets/tile_widget.dart';
import '../entities/confessor_utilities.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String confessorsBoxName = ConfessorUtilities.ConfessorsBoxName;
  String settingsBoxName = Settings.SettingsBoxName;

  void showAddForm(context) {
    Navigator.of(context).pushNamed(AddPage.routeName);
  }

  @override
  void initState() {
    //Provider.of<ConfessorUtilities>(context, listen: false).fetchDatabase();
    print("data retrieved");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddForm(context),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<dynamic>(settingsBoxName).listenable(),
          builder: (context, Box<dynamic> box, child) {
            Settings.readLateMonths();
            print(Settings.lateMonthsNumber);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15.0,
                    bottom: 4.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.late_confessors.tr(),
                        style: headerTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 165,
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<Confessor>(confessorsBoxName).listenable(),
                    builder: (context, Box<Confessor> box, child) {
                      List<Confessor> lateConfessorsList =
                      ConfessorUtilities.filterLateConfessors();
                      return lateConfessorsList.length != 0
                          ? Container(
                        //decoration: horizontalListBoxDecoration,
                        padding: EdgeInsets.all(3.5),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TileWidgetHorizontal(
                                lateConfessorsList[index]);
                          },
                          itemCount: lateConfessorsList.length,
                        ),
                      )
                          : Column(
                        children: [
                          SizedBox(height: 10.0),
                          Center(
                            child: Icon(
                              Icons.alarm_on_rounded,
                              size: 120,
                              color: accentColor,
                            ),
                          ),
                          Text(
                            LocaleKeys.no_late_confessors.tr(),
                            style: contextTextStyle,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15.0,
                    bottom: 4.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.all_confessors.tr(),
                        style: headerTextStyle,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<Confessor>(confessorsBoxName).listenable(),
                    builder: (context, Box<Confessor> box, child) {
                      return box.length != 0
                          ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return TileWidget(box.getAt(index));
                        },
                        itemCount: box.length,
                      )
                          : Column(
                        children: [
                          SizedBox(height: mediaQuery.size.height * 0.12),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Lottie.asset(
                              'assets/animations/emptyDessert.json',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            LocaleKeys.no_confessors_yet.tr(),
                            style: contextTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

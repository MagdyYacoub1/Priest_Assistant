import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/pages/add_page.dart';
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
  static const String BoxName = "confessors";

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Confessor>(BoxName).listenable(),
                builder: (context, Box<Confessor> box, child) {
                  List<Confessor> lateConfessorsList =
                      ConfessorUtilities.filterLateConfessors();
                  return lateConfessorsList.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TileWidgetHorizontal(
                                lateConfessorsList[index]);
                          },
                          itemCount: lateConfessorsList.length,
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
                              "No late confessors yet.",
                              style: contextTextStyle,
                            ),
                          ],
                        );
                },
              ),
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Confessor>(BoxName).listenable(),
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
                              "No confessors added. Start add some confessors to populate the list.",
                              style: contextTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

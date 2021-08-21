import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:priest_assistant/pages/add_page.dart';
import 'package:priest_assistant/widgets/appBar_Builder.dart';
import 'package:provider/provider.dart';

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
  void showAddForm(context) {
    Navigator.of(context).pushNamed(AddPage.routeName);
  }

  @override
  void initState() {
    Provider.of<ConfessorUtilities>(context, listen: false).fetchDatabase();
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
              child: Consumer<ConfessorUtilities>(
                builder: (context, utilities, child) {
                  utilities.filterLateConfessors();
                  return utilities.lateConfessorsList.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TileWidgetHorizontal(
                                utilities.lateConfessorsList, index);
                          },
                          itemCount: utilities.lateConfessorsList.length,
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
              child: Consumer<ConfessorUtilities>(
                builder: (context, utilities, child) {
                  return utilities.confessorsList.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return TileWidget(utilities.confessorsList, index);
                          },
                          itemCount: utilities.confessorsList.length,
                        )
                      : Column(
                          children: [
                            SizedBox(height: mediaQuery.size.height * 0.07),
                            Icon(
                              Icons.hourglass_empty_rounded,
                              size: mediaQuery.size.height * 0.43,
                              color: accentColor,
                            ),
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

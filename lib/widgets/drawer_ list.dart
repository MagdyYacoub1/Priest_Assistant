import 'package:flutter/material.dart';
import '../Styling.dart';
import '../pages/add_page.dart';
import 'package:priest_assistant/pages/statistics_page.dart';


class MyDrawer extends StatelessWidget {

  void showAddForm(context){
    Navigator.of(context).pushNamed(AddPage.routeName);
  }

  void showStatistics(context){
    Navigator.of(context).pushNamed(StatisticsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Priest',
                  style: logoText1TextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  'Assistant',
                  style: logoText2TextStyle,
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Confessor'),
                onTap: () => showAddForm(context),
              ),
              ListTile(
                leading: Icon(Icons.stacked_line_chart),
                title: Text('Statistics'),
                onTap: () => showStatistics(context),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title: Text('About'),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

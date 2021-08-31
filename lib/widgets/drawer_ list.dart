import 'dart:async';

import 'package:flutter/material.dart';
import '../Styling.dart';
import '../pages/add_page.dart';

class MyDrawer extends StatefulWidget {
  final Function toggle;

  const MyDrawer(this.toggle);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Timer _timer;

  void showAddForm(context){
    Navigator.of(context).pushNamed(AddPage.routeName);
    _timer = new Timer(Duration(milliseconds: 300), () => widget.toggle());
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                onTap: (){},
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

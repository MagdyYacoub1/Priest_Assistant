import 'package:flutter/material.dart';
import 'package:priest_assistant/pages/profile_page.dart';
import '../entities/confessor.dart';

class TileWidgetHorizontal extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;

  @override
  TileWidgetHorizontal(this.myConfessors, this.index);

  void showProfile(context){
    Navigator.of(context).pushNamed(ProfilePage.routeName);
  }
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => showProfile(context),
      child: Container(
        constraints: BoxConstraints(
          minWidth: mediaQuery.size.width * 0.5,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE0E0E0), Color(0xFFFFCDD2)])),
        padding: EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 2.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.40,
                    child: Text(
                      myConfessors[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(

                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    myConfessors[index].phone,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'status',
                    style: TextStyle(
                      color: Color(0xFFEF5350),
                      backgroundColor: Color(0xFFFFCDD2),
                      height: 2,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    myConfessors[index].getDate(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../entities/confessor.dart';

class TileWidgetHorizontal extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;

  @override
  TileWidgetHorizontal(this.myConfessors, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE0E0E0), Color(0xFFFFCDD2)])
      ),
      width: 350,
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
                Text(
                  myConfessors[index].name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
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
    );
  }
}

import 'package:flutter/material.dart';
import '../entities/confessor.dart';


class TileWidget extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;

  @override
  TileWidget(this.myConfessors, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 2.0,
        child: ListTile(
          isThreeLine: true,
          leading: Icon(
            Icons.person,
            size: 70,
          ),
          title: Text(
            myConfessors[index].name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Status\n',
                  style: TextStyle(
                    color: Color(0xFFEF5350),
                    backgroundColor: Color(0xFFFFCDD2),
                    height: 2,
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: myConfessors[index].getDate(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          trailing: Icon(
            Icons.arrow_drop_down,
          ),
        ),
      ),
    );
  }
}

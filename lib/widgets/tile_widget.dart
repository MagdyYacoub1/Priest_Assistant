import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../widgets/tile_expansion.dart';
import '../entities/confessor.dart';

class TileWidget extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;

  @override
  TileWidget(this.myConfessors, this.index);

  void showProfile(context){
    Navigator.of(context).pushNamed(ProfilePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.all(2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 2.0,
        child: ExpansionTile(
          leading: InkWell(
            onTap: () => showProfile(context),
            child: Icon(
              Icons.person,
              size: 70,
            ),
          ),
          title: Container(
            width: mediaQuery.size.width * 0.7,
            child: Text(
              myConfessors[index].name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
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
          children: [
            TileExpansion(this.myConfessors[index]),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:priest_assistant/Styling.dart';
import '../pages/profile_page.dart';
import '../widgets/tile_expansion.dart';
import '../entities/confessor.dart';

class TileWidget extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;
  final avatarRadius = 50.0;

  @override
  TileWidget(this.myConfessors, this.index);

  void showProfile(context) {
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
            child: CircleAvatar(
              radius: 30,
              backgroundColor: accentColor,
              backgroundImage: myConfessors[index].photo != null
                  ? MemoryImage(myConfessors[index].photo)
                  : null,
              child: myConfessors[index].photo == null
                  ? Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              )
                  : null,
            ),
          ),
          title: Container(
            width: mediaQuery.size.width * 0.7,
            child: Text(
              myConfessors[index].fName,
              style: nameTextStyle,
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle
                  .of(context)
                  .style,
              children: [
                TextSpan(
                  text: 'Status\n',
                  style: TextStyle(
                    color: Color(0xFFEF5350),
                    height: 2,
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: myConfessors[index].getDate(),
                  style: phone_dateTextStyle,
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

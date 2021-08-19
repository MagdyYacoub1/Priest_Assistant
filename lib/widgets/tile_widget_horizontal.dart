import 'package:flutter/material.dart';
import 'package:priest_assistant/pages/profile_page.dart';
import '../Styling.dart';
import '../entities/confessor.dart';

class TileWidgetHorizontal extends StatelessWidget {
  final List<Confessor> myConfessors;
  final int index;
  final avatarRadius = 40.0;

  @override
  TileWidgetHorizontal(this.myConfessors, this.index);

  void showProfile(context) {
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
        decoration: horizontalListBoxDecoration,
        padding: EdgeInsets.all(3.5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: myConfessors[index].photo != null? Colors.white: accentColor,
                  radius: avatarRadius,
                  child: myConfessors[index].photo != null
                      ? ClipOval(
                        child: Image.memory(
                    myConfessors[index].photo,
                    fit: BoxFit.fill,
                  ),
                      )
                      : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: mediaQuery.size.width * 0.40,
                      child: Text(
                        myConfessors[index].fName,
                        overflow: TextOverflow.ellipsis,
                        style: nameTextStyle,
                      ),
                    ),
                    Text(
                      myConfessors[index].phone,
                      style: phone_dateTextStyle,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'status',
                      style: statusTextStyle,
                    ),
                    Text(
                      myConfessors[index].getDate(),
                      style: phone_dateTextStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

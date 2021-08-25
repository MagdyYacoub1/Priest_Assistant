import 'package:flutter/material.dart';
import 'package:priest_assistant/pages/profile_page.dart';
import '../Styling.dart';
import '../entities/confessor.dart';

class TileWidgetHorizontal extends StatelessWidget {
  final Confessor myConfessor;
  final avatarRadius = 40.0;

  @override
  TileWidgetHorizontal(this.myConfessor);

  void showProfile(context, Confessor myConfessor) {
    Navigator.of(context)
        .pushNamed(ProfilePage.routeName, arguments: myConfessor);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => showProfile(context, myConfessor),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: accentColor,
                  radius: avatarRadius,
                  backgroundImage: myConfessor.photo != null
                      ? MemoryImage(
                          myConfessor.photo,
                        )
                      : null,
                  child: myConfessor.photo == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                      : null,
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: mediaQuery.size.width * 0.40,
                      child: Text(
                        myConfessor.fName + " " + myConfessor.lName,
                        overflow: TextOverflow.ellipsis,
                        style: nameTextStyle,
                      ),
                    ),
                    Text(
                      myConfessor.phone,
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
                      myConfessor.getDate(),
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

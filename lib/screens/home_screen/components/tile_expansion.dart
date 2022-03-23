import 'package:flutter/material.dart';
import '../../profile_screen/profile_page.dart';
import '../../../styling.dart';
import '../../../entities/confessor.dart';

class TileExpansion extends StatelessWidget {
  final Confessor? myConfessor;

  @override
  TileExpansion(this.myConfessor);

  void showProfile(context, Confessor myConfessor) {
    Navigator.of(context)
        .pushNamed(ProfilePage.routeName, arguments: myConfessor.key);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //NumberFormat f = NumberFormat("##", context.locale.toString());
    final double screenPercent = 0.80;
    return InkWell(
      onTap: () => showProfile(context, myConfessor!),
      child: Container(
        //decoration: gradientColorAndDirection(context, myConfessors.isLate()),
        child: Card(
          color: extensionColor,
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
          ),*/
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      width: mediaQuery.size.width * screenPercent,
                      child: Text(
                        '${myConfessor!.email}',
                        style: expansionTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: mediaQuery.size.width * screenPercent,
                  child: const Divider(
                    color: dividerColor,
                    endIndent: 40.0,
                    indent: 40.0,
                    thickness: 2.0,
                    height: 30.0,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.call,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      '(${myConfessor!.countryCode}) ${myConfessor!.phone}',
                      style: expansionTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  width: mediaQuery.size.width * screenPercent,
                  child: const Divider(
                    color: dividerColor,
                    endIndent: 40.0,
                    indent: 40.0,
                    thickness: 2.0,
                    height: 30.0,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notes,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      width: mediaQuery.size.width * screenPercent,
                      child: Text(
                        '${myConfessor!.notes.length != 0 ? myConfessor!.notes.last.content : ""}',
                        style: expansionTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

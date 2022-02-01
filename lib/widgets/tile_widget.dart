import 'package:flutter/material.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../pages/profile_page.dart';
import '../widgets/tile_expansion.dart';
import '../entities/confessor.dart';

class TileWidget extends StatelessWidget {
  final Confessor? myConfessor;
  final avatarRadius = 50.0;

  @override
  TileWidget(this.myConfessor);

  void showProfile(context, Confessor myConfessor) {
    Navigator.of(context)
        .pushNamed(ProfilePage.routeName, arguments: myConfessor.key);
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
            onTap: () => showProfile(context, myConfessor!),
            child: Hero(
              tag: myConfessor.toString(),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: accentColor,
                backgroundImage: myConfessor!.photo != null
                    ? MemoryImage(
                        myConfessor!.photo!,
                      )
                    : null,
                child: myConfessor!.photo == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
          title: Container(
            width: mediaQuery.size.width * 0.7,
            child: Text(
              myConfessor!.fName + " " + myConfessor!.lName,
              style: nameTextStyle,
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: myConfessor!.isLate() ? LocaleKeys.late_status.tr()+'\n' : LocaleKeys.good_status.tr()+'\n',
                  style: myConfessor!.isLate()
                      ? redStatusTextStyle
                      : greenStatusTextStyle,
                ),
                TextSpan(
                  text: myConfessor!.getDate(context.locale),
                  style: phone_dateTextStyle,
                ),
              ],
            ),
          ),
          trailing: Icon(
            Icons.arrow_drop_down,
          ),
          children: [
            TileExpansion(this.myConfessor),
          ],
        ),
      ),
    );
  }
}

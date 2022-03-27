import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import '../../../translations/localization_constants.dart';
import '../../profile_screen/profile_page.dart';
import '../../../styling.dart';
import '../../../entities/confessor.dart';
import 'data_line.dart';

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
                DataLine(
                  icon: Icons.email_outlined,
                  data: myConfessor!.email != ""
                      ? '${myConfessor!.email}'
                      : LocaleKeys.no_email.tr(),
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
                DataLine(
                  icon: Icons.call_outlined,
                  data: context.locale.languageCode ==
                          languageList[0].languageCode
                      ? '(${myConfessor!.countryCode}) ${myConfessor!.phone}'
                      : '${myConfessor!.phone} (${myConfessor!.countryCode}) ',
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
                DataLine(
                  icon: Icons.notes_outlined,
                  data: '${myConfessor!.notes.last.content}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:priest_assistant/screens/profile_screen/profile_page.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../styling.dart';
import '../../../entities/confessor.dart';

class TileWidgetHorizontal extends StatelessWidget {
  final Confessor myConfessor;
  final avatarRadius = 40.0;

  @override
  TileWidgetHorizontal(this.myConfessor);

  void showProfile(context, Confessor myConfessor) {
    Navigator.of(context)
        .pushNamed(ProfilePage.routeName, arguments: myConfessor.key);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () => showProfile(context, myConfessor),
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
                        myConfessor.photo!,
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
                  Text(
                    LocaleKeys.late_status.tr(),
                    style: redStatusTextStyle,
                  ),
                  Text(
                    myConfessor.getDate(context.locale),
                    style: phone_dateTextStyle,
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

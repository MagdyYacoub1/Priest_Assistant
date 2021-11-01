import 'package:flutter/material.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/translations/localization_constants.dart';

import '../widgets/custom_drawer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.appBar_title.tr(),
        style: appBarTextStyle,
      ),
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),*/
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton<int>(
            onSelected: (value) async {
              switch (value) {
                case 0:
                  await context.setLocale(Locale(
                      languageList[value].languageCode,
                      languageList[value].countryCode));
                  break;
                case 1:
                  await context.setLocale(Locale(
                      languageList[value].languageCode,
                      languageList[value].countryCode));
                  break;
              }
            },
            enableFeedback: true,
            itemBuilder: (context) => [
              ...List.generate(
                languageList.length,
                (index) => PopupMenuItem(
                  value: index,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        languageList[index].flag,
                        style: appBarTextStyle,
                      ),
                      Text(languageList[index].name),
                    ],
                  ),
                ),
              )
            ],
            icon: Icon(
              Icons.language,
              color: Colors.white,
            ),
            iconSize: 30.0,
            elevation: 10,
          ),
        )
      ],
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: () => CustomDrawer.of(context).toggle(),
          );
        },
      ),
    );
  }
}

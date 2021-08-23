import 'package:flutter/material.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/language.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            onChanged:  (Language language) async{
               await context.setLocale(Locale(language.languageCode, language.countryCode));
            },
            underline: SizedBox(),
            items: languageList
                .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    lang.flag,
                    style: appBarTextStyle,
                  ),
                  Text(lang.name),
                ],
              ),
            ))
                .toList(),
            icon: Icon(
              Icons.language,
              size: 30,
              color: Colors.white,
            ),
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

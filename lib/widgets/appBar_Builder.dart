import 'package:flutter/material.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:priest_assistant/localization/language.dart';
import 'package:priest_assistant/localization/my_localization.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_drawer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        MyLocalization.of(context).getTranslatedValue('appBar_title'),
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
            onChanged: (Language language) {
              Provider.of<MyLocalization>(context, listen: false)
                  .setLocale(language.languageCode);
            },
            underline: SizedBox(),
            items: Language.languageList()
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

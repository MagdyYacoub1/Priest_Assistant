import 'package:flutter/material.dart';
import 'package:priest_assistant/styling.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:priest_assistant/screens/home_screen/components/search_delegate.dart';

import '../../../widgets/custom_drawer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  void showSearchPage(BuildContext context) {
    showSearch(
      context: context,
      delegate: AppSearchDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.appBar_title.tr(),
        style: appBarTextStyle,
      ),
      actions: [
        IconButton(
          onPressed: () => showSearchPage(context),
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ],
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: CustomDrawer.of(context)!.animation,
              size: 30,
            ),
            onPressed: () => CustomDrawer.of(context)!.toggle(),
          );
        },
      ),
    );
  }
}

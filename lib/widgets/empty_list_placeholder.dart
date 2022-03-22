import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Styling.dart';
import '../translations/locale_keys.g.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(height: mediaQuery.size.height * 0.12),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.12,
          ),
          child: Lottie.asset(
            'assets/animations/emptyDessert.json',
          ),
        ),
        const SizedBox(height: 20),
        Text(
          LocaleKeys.no_confessors_yet.tr(),
          style: contextTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

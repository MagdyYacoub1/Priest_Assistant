import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../styling.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({
    Key? key,
    required this.animationPath,
    required this.description,
  }) : super(key: key);

  final String animationPath;
  final String description;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: mediaQuery.size.height * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.width * 0.12,
            ),
            child: Lottie.asset(
              animationPath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15.0,
              bottom: 4.0,
            ),
            child: Text(
              description,
              style: contextTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

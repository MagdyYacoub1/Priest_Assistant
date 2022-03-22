import 'package:flutter/material.dart';
import 'package:priest_assistant/entities/confessor.dart';

import '../Styling.dart';
import '../pages/profile_page.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, required this.myConfessor}) : super(key: key);

  final Confessor? myConfessor;

  void showProfile(context) {
    Navigator.of(context)
        .pushNamed(ProfilePage.routeName, arguments: myConfessor!.key);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showProfile(context);
      },
      leading: Hero(
        tag: myConfessor.toString(),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: accentColor,
          backgroundImage: myConfessor?.photo != null
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
      title: Text(
        myConfessor!.fName + " " + myConfessor!.lName,
        //style: nameTextStyle,
      ),
      style: ListTileStyle.list,
      subtitle: Text(myConfessor!.phone),
    );
  }
}

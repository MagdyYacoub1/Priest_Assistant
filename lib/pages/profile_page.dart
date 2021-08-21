import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:priest_assistant/Styling.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/localization/localization_constants.dart';
import 'package:priest_assistant/localization/my_localization.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile_page";
  final avatarRadius = 100.0;



  //190, -100
  //(-210, 110)
  @override
  Widget build(BuildContext context) {
    final _locale = Provider.of<MyLocalization>(context).locale;
    final mediaQuery = MediaQuery.of(context);
    final Confessor myConfessor = ModalRoute.of(context).settings.arguments as Confessor;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -100,
            top: -140,
            child: Container(
              height: mediaQuery.size.height * 0.35,
              width: mediaQuery.size.height * 0.35,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -120,
            top: 120,
            child: Container(
              height: mediaQuery.size.height * 0.25,
              width: mediaQuery.size.height * 0.25,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            color: myConfessor.isLate() == true ? backgroundRed : backgroundGreen,
            height: mediaQuery.size.height * 0.33,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              iconSize: 30.0,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.25,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.0,
                      ),
                      Center(
                        child: Text(
                          myConfessor.fName + " " + myConfessor.lName,
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          myConfessor.email,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(
                                Icons.call,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            VerticalDivider(
                              thickness: 2.0,
                              color: Colors.grey,
                              indent: 7.0,
                              endIndent: 7.0,
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            VerticalDivider(
                              thickness: 2.0,
                              color: Colors.grey,
                              indent: 7.0,
                              endIndent: 7.0,
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Transform.translate(
            offset: (_locale.languageCode == Arabic)
                ? Offset((-mediaQuery.size.width / 2) + avatarRadius,
                    (mediaQuery.size.height * 0.25) - avatarRadius)
                : Offset((mediaQuery.size.width / 2) - avatarRadius,
                    (mediaQuery.size.height * 0.25) - avatarRadius),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: avatarRadius,
              child: Hero(
                tag: myConfessor.toString(),
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  radius: avatarRadius - 15,
                  backgroundImage: myConfessor.photo != null
                      ? MemoryImage(myConfessor.photo)
                      : null,
                  child: myConfessor.photo == null
                      ? Icon(
                    Icons.person,
                    size: avatarRadius - 15,
                    color: Colors.white,
                  )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile_page";
  final avatarRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(190, -100),
            child: Container(
              height: mediaQuery.size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-210, 110),
            child: Container(
              height: mediaQuery.size.height * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFF20315F),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            color: Color(0XFF2E7D32).withOpacity(0.9),
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
                          "Confessor Name",
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          "confessoremail@gmail.com",
                          style: TextStyle(
                            fontSize: 15.0,
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
                        child: IntrinsicHeight(
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Transform.translate(
            offset: Offset((mediaQuery.size.width / 2) - avatarRadius,
                (mediaQuery.size.height * 0.25) - avatarRadius),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: avatarRadius,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: avatarRadius - 15,
                backgroundImage: AssetImage("assets/images/person image.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

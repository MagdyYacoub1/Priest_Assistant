import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../styling.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../widgets/snackBar_widget.dart';

class CommunicationCard extends StatelessWidget {
  const CommunicationCard({Key? key, required this.myConfessor})
      : super(key: key);

  final Confessor myConfessor;

  void onMassageOptionSelected(BuildContext context, int value) {
    switch (value) {
      case 0:
        sendMessageWithMessages(
          context,
          myConfessor.countryCode,
          myConfessor.phone,
        );
        break;
      case 1:
        sendMessageWithWhatsApp(
          context,
          myConfessor.countryCode,
          myConfessor.phone,
        );
        break;
    }
  }

  void makePhoneCall(
      BuildContext context, String countryCode, String phoneNumber) async {
    if (phoneNumber[0] == '0')
      phoneNumber = phoneNumber.substring(1, phoneNumber.length);
    String url = "tel:" + countryCode + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSnackBar(context, LocaleKeys.phone_call_error_msg.tr());
    }
  }

  void sendEmail(BuildContext context, String? email) async {
    if (email!.isNotEmpty) {
      String uri = Uri(
        scheme: 'mailto',
        path: email,
      ).toString();
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        showSnackBar(context, LocaleKeys.send_email_error_msg.tr());
      }
    } else {
      showSnackBar(context, LocaleKeys.no_email_error_msg.tr());
    }
  }

  void sendMessageWithMessages(
      BuildContext context, String countryCode, String phoneNumber) async {
    if (phoneNumber[0] == '0')
      phoneNumber = phoneNumber.substring(1, phoneNumber.length);
    String url = "sms:" + countryCode + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSnackBar(context, LocaleKeys.messages_error_msg.tr());
    }
  }

  void sendMessageWithWhatsApp(
      BuildContext context, String countryCode, String phoneNumber) async {
    if (phoneNumber[0] == '0')
      phoneNumber = phoneNumber.substring(1, phoneNumber.length);
    String url = "whatsapp://send?phone=" + countryCode + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showSnackBar(context, LocaleKeys.whatsApp_error_msg.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 30.0,
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.grey,
            ),
            onPressed: () => makePhoneCall(
              context,
              myConfessor.countryCode,
              myConfessor.phone,
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (value) => onMassageOptionSelected(context, value),
            enableFeedback: true,
            itemBuilder: (context) => [
              buildPopupMenuItem(
                value: 0,
                icon: const Icon(
                  Icons.message_rounded,
                  color: Colors.grey,
                ),
                label: LocaleKeys.messages.tr(),
              ),
              buildPopupMenuItem(
                value: 1,
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.grey,
                ),
                label: LocaleKeys.whatsApp.tr(),
              ),
            ],
            offset: Offset(0.0, 40.0),
            icon: Icon(
              Icons.message_outlined,
              color: Colors.grey,
            ),
            iconSize: 30.0,
          ),
          IconButton(
            iconSize: 30.0,
            icon: const Icon(
              Icons.email_outlined,
              color: Colors.grey,
            ),
            onPressed: () => sendEmail(context, myConfessor.email),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<int> buildPopupMenuItem({
    required int value,
    required Widget icon,
    required String label,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: 15.0),
          Text(
            label,
            style: hintTextStyle,
          )
        ],
      ),
    );
  }
}

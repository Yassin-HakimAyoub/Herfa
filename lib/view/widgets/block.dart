import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../screens/designs/drawar.dart';

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "محظور",
          style: AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
        ),
        const Icon(
          Icons.block,
          color: Colors.red,
          size: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "تم حظرك من استخدام التطبيق الرجاء التواصل مع المسؤولين عن التطبيق",
          textAlign: TextAlign.center,
          style: AppStyles.textBoldStyleColor(color: Colors.black, size: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            socialMedia(
                click: () async {
                  final link = WhatsAppUnilink(
                      phoneNumber: "+249992711704",
                      text:
                          "انا ${sharedPreferences.getString(AppConst.userName)} لماذا تم حظري ؟");
                  await launchUrl(link.asUri());
                },
                icon: Icons.chat),
            socialMedia(
                click: () async {
                  final Uri lauCall = Uri(scheme: "tel", path: "0992711704");
                  await launchUrl(lauCall);
                },
                icon: Icons.call),
          ],
        )
      ],
    ));
  }
}

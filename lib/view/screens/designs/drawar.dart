import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/your_account.dart';
import 'package:services/view/screens/user/your_ratinges.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

Drawer MyDrawar(BuildContext context,
    {required String name, required String email, required UserTypes types}) {
  return Drawer(
    width: screenWidth(context) - 120,
    child: Column(
      children: [
        UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(AppImages.secoLogo),
            ),
            accountName: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            accountEmail: Text(email,
                style: const TextStyle(fontSize: 12, fontFamily: "Cairo"))),
        ListTile(
          title: Text("حسابك",
              style: AppStyles.textStyleColor(color: Colors.black, size: 12)),
          leading: const Icon(Icons.account_box_rounded),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => YourAccount(
                        id: FirebaseAuth.instance.currentUser!.uid,
                        types: types)));
          },
        ),
        types == UserTypes.WORKER
            ? ListTile(
                title: Text("الفواتير",
                    style: AppStyles.textStyleColor(
                        color: Colors.black, size: 12)),
                leading: const Icon(Icons.my_library_books_outlined),
                onTap: () {
                  Get.toNamed(AppRoutes.viewmoney);
                },
              )
            : Container(),
        types == UserTypes.WORKER
            ? ListTile(
                title: Text("التقييمات",
                    style: AppStyles.textStyleColor(
                        color: Colors.black, size: 12)),
                leading: const Icon(Icons.star),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YouRatinges(
                              workerId:
                                  FirebaseAuth.instance.currentUser!.uid)));
                },
              )
            : Container(),
        ListTile(
          onTap: () {
            Get.defaultDialog(
                title: "المبرمح",
                titleStyle:
                    AppStyles.textBoldStyleColor(color: Colors.black, size: 15),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AppImages.myImage),
                    ),
                    Text(
                      "ياسين حكيم ايوب مبرمج تطبيقات اندرويد مع خبرة 4 سنوات  و هذه احد اعمالي للتواصل مع على مواقع التواصل الاجتماعي",
                      textAlign: TextAlign.center,
                      style: AppStyles.textBoldStyleColor(
                          color: Colors.black, size: 12),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        socialMedia(
                            icon: Icons.call,
                            click: () async {
                              final Uri lauCall =
                                  Uri(scheme: "tel", path: "0992711704");
                              await launchUrl(lauCall);
                            }),
                        socialMedia(
                            icon: Icons.email,
                            click: () async {
                              final Uri lauMail = Uri(
                                  scheme: "mailto",
                                  path: "yassinhakim2001@gmail.com");
                              await launchUrl(lauMail);
                            }),
                        socialMedia(
                            icon: Icons.chat,
                            click: () async {
                              final link = WhatsAppUnilink(
                                  phoneNumber: "+249992711704",
                                  text: " السلام عليك , يا ياسين حكيم");
                              await launchUrl(link.asUri());
                            })
                      ],
                    )
                  ],
                ));
          },
          title: Text(
            "المبرمج",
            style: AppStyles.textStyleColor(color: Colors.black, size: 12),
          ),
          leading: const Icon(Icons.android),
        ),
        ListTile(
          onTap: () {
            Get.defaultDialog(
                title: "عن التطبيق",
                titleStyle:
                    AppStyles.textBoldStyleColor(color: Colors.black, size: 15),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(AppImages.logo2),
                      )),
                    ),
                    Text(
                      " تطبيق حرفة هو تطبيق مقدم من شركة SECO يعمل التطبيق على توفير الوظائف و ربط مقدمي الخدمة مع العملاء",
                      textAlign: TextAlign.center,
                      style: AppStyles.textBoldStyleColor(
                          color: Colors.black, size: 12),
                    )
                  ],
                ));
          },
          title: Text("عن التطبيق",
              style: AppStyles.textStyleColor(color: Colors.black, size: 12)),
          leading: const Icon(Icons.info),
        ),
        ListTile(
          onTap: () {
            Get.defaultDialog(
                title: "الخروح من التطبيق",
                actions: [
                  TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        "نعم",
                        style: AppStyles.textBoldStyleColor(
                            color: Colors.blue, size: 12),
                      )),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("لا",
                          style: AppStyles.textBoldStyleColor(
                              color: Colors.red, size: 12)))
                ],
                titleStyle:
                    AppStyles.textBoldStyleColor(color: Colors.black, size: 15),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "هل تريد تسجيل خروج من حسابك على التطبيق ؟",
                      textAlign: TextAlign.center,
                      style: AppStyles.textBoldStyleColor(
                          color: Colors.black, size: 10),
                    ),
                  ],
                ));
          },
          title: Text("خروج",
              style: AppStyles.textStyleColor(color: Colors.black, size: 12)),
          leading: const Icon(Icons.exit_to_app),
        )
      ],
    ),
  );
}

socialMedia({required IconData icon, required Function() click}) {
  return CircleAvatar(
      radius: 20,
      child: IconButton(
        onPressed: click,
        icon: Icon(icon),
      ));
}

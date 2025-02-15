import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/main.dart';

class VerifiedController extends GetxController {
  late bool isVerified;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    sharedPreferences.setString(AppConst.isOnBoarding, "2");
    try {
      isVerified = user!.emailVerified;
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        user!.sendEmailVerification();
      }
    } catch (e) {}

    super.onInit();
  }

  goTo() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "${FirebaseAuth.instance.currentUser!.email}",
            password: sharedPreferences.getString(AppConst.userPass)!);

    if (userCredential.user!.emailVerified == true) {
      Get.offAllNamed(AppRoutes.checkScreen);
      sharedPreferences.setString(AppConst.isOnBoarding, "3");
    } else {
      Get.defaultDialog(
          title: "تحقق",
          titleStyle:
              AppStyles.textBoldStyleColor(color: Colors.black, size: 19),
          content: Column(
            children: [
              Text(
                "لم تقم بي التحقق من البريد الالكتروني",
                textAlign: TextAlign.center,
                style: AppStyles.textStyleColor(color: Colors.black, size: 15),
              )
            ],
          ));
    }
  }

  sendAgain() {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Get.defaultDialog(
          title: "التحقق",
          titleStyle: AppStyles.textBoldStyleColor(color: Colors.black, size: 15),
          content: Text(
            "تم ارسال رسالة التحقق الى بريدك مرة اخرى",
            textAlign: TextAlign.center,
            style: AppStyles.textStyleColor(color: Colors.black, size: 14),
          ));
    }
  }
}

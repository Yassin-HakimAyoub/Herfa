import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/main.dart';

// ignore: camel_case_types
class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}

// ignore: camel_case_types
class splashState extends State<splashScreen> {
  int second = 7;
  // var isOn = sharedPreferences.getBool("1") ?? false;
  //var isPass = sharedPreferences.getBool(usePass);
  //sharedPreferences.getString(AppConst.isOnBoarding) ?? "1";
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        second--;
        if (second == 0) {
          timer.cancel();
          if (sharedPreferences.getString(AppConst.isOnBoarding) == "1") {
            Get.offAllNamed(AppRoutes.onboarding);
          } else if (sharedPreferences.getString(AppConst.isOnBoarding) ==
              "2") {
                Get.offAllNamed(AppRoutes.verifyCode);
          } else if (sharedPreferences.getString(AppConst.isOnBoarding) ==
              "3") {
                if(FirebaseAuth.instance.currentUser != null){
                  Get.offAllNamed(AppRoutes.checkScreen);
                }else{
                  Get.offAllNamed(AppRoutes.login);
                }
          } else {
            Get.offAllNamed(AppRoutes.onboarding);
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appMainColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              AppImages.splashLogo,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            Text('حِرفة' , style: AppStyles.textBoldStyleColor(color: Colors.white, size: 40),),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "By:YassinHakim",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      )),
    );
  }
}

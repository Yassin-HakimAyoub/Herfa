import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/main.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  //AppInitController initController = Get.put(AppInitController());

  enterRules() async {
    var userData = await FirebaseFunctions.getOneColumn(
        id: FirebaseAuth.instance.currentUser!.uid,
        column: FirebaseConst.users);
    if (userData[FirebaseConst.userCanEnter] == false) {
      Get.offAllNamed(AppRoutes.block);
    } else if (userData[FirebaseConst.userPay] == false) {
      Get.offAllNamed(AppRoutes.payscreen);
    } else {
      if (userData[FirebaseConst.userIsWorker] == true) {
        Get.offAllNamed(AppRoutes.workerhome);
        sharedPreferences.setString(
            AppConst.userName, userData[FirebaseConst.userName]);
        sharedPreferences.setBool(UserConst.userIsworker, true);
      } else if (userData[FirebaseConst.userIsWorker] == false) {
        Get.offAllNamed(AppRoutes.home);
        sharedPreferences.setString(
            AppConst.userName, userData[FirebaseConst.userName]);
        sharedPreferences.setBool(UserConst.userIsworker, false);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  @override
  void initState() {
    sharedPreferences.setString(AppConst.isOnBoarding, "3");
    enterRules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
          
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "فحص البيانات ...",
              style:
                  AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
            ),
          ),
          
        ],
      ),
    );
  }
}

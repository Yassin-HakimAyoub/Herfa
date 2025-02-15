import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';

abstract class SignUpController extends GetxController {
  signUp(BuildContext context,
      {required String username,
      required String email,
      required String pass,
      required String phone,
      bool isworker,
      String workerDis});
  goToLogin();
  goToVerify();
}

class SignUpControllerImp extends SignUpController {
  String selectedState = "";
  String selectedwork = "";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isloading = false;

  @override
  void onInit() {
    AppFunctions.getPosition();
    selectedState = AppFunctions.myLocation;
    super.onInit();
  }

  @override
  goToLogin() {
    Get.offNamed(AppRoutes.login);
  }

  updateWork(String work) {
    selectedwork = work;
    update();
  }

  @override
  signUp(BuildContext context,
      {required String username,
      required String email,
      required String pass,
      required String phone,
      bool isworker = false,
      String workerDis = ""}) async {
    if (formstate.currentState!.validate()) {
      AppFunctions.lodingDailog();
      FirebaseFunctions.createAccountWithEmailAndPassword(
          email: email,
          passwrd: pass,
          colectionName: FirebaseConst.users,
          name: username,
          phone: phone,
          discription: workerDis,
          isworker: isworker,
          location: selectedState,
          selectWork: selectedwork);
    }
  }

  @override
  goToVerify() {
    Get.offAllNamed(AppRoutes.verifyCode);
  }
}

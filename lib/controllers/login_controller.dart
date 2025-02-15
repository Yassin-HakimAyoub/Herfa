import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';

abstract class LoginController extends GetxController {
  
  login(
      {required BuildContext context,
      required String email,
      required String password});
  goToHome();
  goToForgetPassword();
  goTo();
}

class LoginConttrollerImp extends LoginController {
  //late TextEditingController email;
  //late TextEditingController password;
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  bool isShowPassword = true;
  bool isLoading = false;
  

  changeShowPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  goToForgetPassword() {
    throw UnimplementedError();
  }

  @override
  goToHome() {
    Get.offNamed(AppRoutes.home);
  }

  @override
  login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    var formdata = fromstate.currentState;
    if (formdata!.validate()) {
      AppFunctions.lodingDailog();
      FirebaseFunctions.loginWithEmail(context,
          email: email, password: password);
    }
  }

  @override
  goTo() {}
}

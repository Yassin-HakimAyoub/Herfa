import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/view/widgets/defult_button.dart';
import 'package:services/view/widgets/mytextforms.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return forgetpasswordState();
  }
}

class forgetpasswordState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "نسيت كلمة امرور",
            style: AppStyles.textBoldStyleColor(color: Colors.black, size: 18),
          ),
        ),
        body: Column(children: [
          Text(
            "فم بكتابة البريد الالكتروني الذي قمت بالتسجيل به و سيتم ارسال رابط في بريدك الالكتروني لتغيير كلمة المرور",
            textAlign: TextAlign.center,
            style: AppStyles.textStyleColor(color: Colors.black, size: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: customTextFiled(
                  hinttext: AppHints.emailHint,
                  isPassword: false,
                  valid: (val) {
                    return validInput(val!, 5, 30, "email");
                  },
                  editingController: email,
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email,
                  labeltext: AppHints.emailLable),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          defultButton(
              text: "ارسل",
              click: () {
                if (email.text.isNotEmpty) {
                  AppFunctions.lodingDailog();
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email.text)
                      .then((value) {
                    Get.offAllNamed(AppRoutes.successrewirtePass);
                  });
                }
              })
        ]));
  }
}

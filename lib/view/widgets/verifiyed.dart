import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/view/widgets/defult_button.dart';

class VerifiyedScreen extends StatelessWidget {
  const VerifiyedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.verified,
            color: Colors.white,
            size: 200,
          ),
          const Text(
              "تم التحقق من بريدك الالكتروني بنجاح الان يمكنك الدخول الى التطبيق "),
          defultButton(
              text: "دخول",
              click: () {
                Get.offAllNamed(AppRoutes.checkScreen);
              })
        ],
      )),
    );
  }
}

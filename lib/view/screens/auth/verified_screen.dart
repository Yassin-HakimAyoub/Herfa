import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/controllers/verified_controller.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/view/widgets/defult_button.dart';

// ignore: must_be_immutable
class VerifiedScreen extends GetView<VerifiedController> {
  VerifiedController verifyController = Get.put(VerifiedController());

  VerifiedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "التحقق من البريد الالكتروني",
            textAlign: TextAlign.center,
            style: AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "تم ارسال رسالة التحقق  الى بريدك الذي سجلت به الرجاء التحقق من البريد عبر الضعط على الرابط",
            textAlign: TextAlign.center,
            style: AppStyles.textBoldStyleColor(color: Colors.black, size: 12),
          ),
          const SizedBox(
            height: 40,
          ),
          CircleAvatar(
            backgroundColor: AppColor.appMainColor,
            radius: 60,
            child: const Icon(
              Icons.email,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          TextButton(
              onPressed: () {
                verifyController.sendAgain();
              },
              child: Text(
                "ارسال الكود مرة اخرى ؟",
                style: AppStyles.textStyleColor(
                    color: AppColor.appMainColor, size: 14),
              )),
          defultButton(
              text: "تحقق",
              click: () async {
                verifyController.goTo();
              }),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/size_func.dart';

class SuccessRewritePassword extends StatelessWidget {
  const SuccessRewritePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.email,
            color: Colors.white,
            size: 150,
          ),
          Text(
            "لقد ارسلنا لك رابط إعادة تعيين كلمة المرور في البريد الالكتروني أضغط على الرابط لتتم العملية",
            textAlign: TextAlign.center,
            style: AppStyles.textBoldStyleColor(color: Colors.white, size: 14),
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed(AppRoutes.login);
            },
            child: Container(
              width: screenWidth(context) - 30,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Text(
                "تم",
                style: AppStyles.textBoldStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

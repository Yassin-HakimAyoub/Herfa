import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/size_func.dart';

class BookingOk extends StatelessWidget {
  const BookingOk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          CircleAvatar(radius: 90,backgroundColor: Colors.white, child:const Icon(
            Icons.check,
            color: AppColor.appMainColor,
            size: 150,
          ) ,),
          
          Text(
            "تم ارسال طلبك بنجاح الى مقدم الخدمة في انتظار الرد على الطلب",
            textAlign: TextAlign.center,
            style: AppStyles.textBoldStyleColor(color: Colors.white, size: 14),
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed(AppRoutes.home);
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

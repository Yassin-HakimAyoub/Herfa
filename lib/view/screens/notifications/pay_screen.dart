import 'package:flutter/material.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/drawar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "دفع الاشتراك",
            style: AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
          ),
          Text(
            "انتهت الفترة المجانية في التطبيق و لي استكمال استعمال التطبيق الرجاء دفع مبلغ التسجيل 500 حنيه تدفع عن طريق محفظة كاشي على رقم الحساب التالي و  عمل لقطة شاشة للاشعار و ارسال الاشعار عبرالواتساب لاستكمال عملية التسجيل ",
            textAlign: TextAlign.center,
            style: AppStyles.textStyleColor(color: Colors.black, size: 14),
          ),
          Container(
            width: screenWidth(context) - 20,
            height: 70,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Text("رقم حساب كاشي : 400121093",
                style: AppStyles.textBoldStyleColor(
                    color: Colors.black, size: 15)),
          ),
          Container(
            width: screenWidth(context) - 20,
            height: 70,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Text("رقم  الواتساب : 0992711704",
                style: AppStyles.textBoldStyleColor(
                    color: Colors.black, size: 15)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialMedia(
                  click: () async {
                    final link = WhatsAppUnilink(
                        phoneNumber: "+249992711704",
                        text:"هذا هو الاشعار");
                    await launchUrl(link.asUri());
                  },
                  icon: Icons.chat),
              SizedBox(
                width: 20,
              ),
              socialMedia(
                  click: () async {
                    final Uri lauCall = Uri(scheme: "tel", path: "0992711704");
                    await launchUrl(lauCall);
                  },
                  icon: Icons.call),
            ],
          )
        ],
      ),
    );
  }
}

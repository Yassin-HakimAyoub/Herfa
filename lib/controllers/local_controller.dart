import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language =  const Locale("ar");
  myServices mySer = Get.find();

  changeLang(String lang) {
    Locale locale = Locale(lang);
    mySer.sharedPreferences.setString("lang", lang);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPer = mySer.sharedPreferences.getString("lang");
    if (sharedPer == "ar") {
      language = const Locale("ar");
    } else if (sharedPer == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}

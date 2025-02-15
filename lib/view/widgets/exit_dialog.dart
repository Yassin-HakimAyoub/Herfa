import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

exitfromApp() {
  return Get.defaultDialog(
      title: "خروج",
      middleText: "هل تريد الخروج من التطبيق",
      actions: [
        ElevatedButton(
            onPressed: () {
              exit(0);
            },
            child: Text("نعم")),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("لا")),
      ]);
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/firebase_functions.dart';

class WorkerImagesController extends GetxController {
  
  uploadImage() async {
    var imagePacker = ImagePicker();
    late XFile? imagePicked;
    if (await Permission.storage.request().isGranted) {
      Get.defaultDialog(
          title: "اختر صورة",
          titleStyle: AppStyles.textBoldStyle(),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: imageType(text: "المعرض", icon: Icons.image),
                onTap: () async {
                  imagePicked =
                      await imagePacker.pickImage(source: ImageSource.gallery);
                  FirebaseFunctions.pickedImageFunction(
                      imagePicked: imagePicked);
                },
              ),
              GestureDetector(
                child: imageType(
                    text: "الكاميرا", icon: Icons.camera_alt_outlined),
                onTap: () async {
                  imagePicked =
                      await imagePacker.pickImage(source: ImageSource.camera);
                  FirebaseFunctions.pickedImageFunction(
                      imagePicked: imagePicked);
                },
              )
            ],
          ));
    } else {
      Permission.photos.request();
    }
  }
}

addImage(ImagePicker imagePicked) {}
imageType({required String text, required IconData icon}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(icon),
      Text(
        text,
        style: const TextStyle(
            fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
      )
    ],
  );
}

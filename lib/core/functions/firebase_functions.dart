import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/func.dart';
import 'package:path/path.dart' as path;

import 'package:services/main.dart';

//${sharedPreferences.getString(UserConst.userName)}
class FirebaseFunctions {
  static addBooking(
    BuildContext context, {
    required String senderId,
    required String workerId,
    required String senderName,
    required String workerName,
    required String locations,
    required String services,
    required int distanceBetween,
    required String text,
  }) {
    int ranId = Random().nextInt(80000) * 3486;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      var docsnap = await transaction.get(booked.doc("$ranId"));
      if (!docsnap.exists) {
        booked.doc("$ranId").set({
          FirebaseConst.bookingSenderId: senderId,
          FirebaseConst.bookingWorkerId: workerId,
          FirebaseConst.bookingWorkerName: workerName,
          FirebaseConst.bookingId: "$ranId",
          FirebaseConst.bookingText: text,
          FirebaseConst.bookingLocation: locations,
          FirebaseConst.bookingdistanceBetween: distanceBetween,
          FirebaseConst.bookingService: services,
          FirebaseConst.bookingRead: false,
          FirebaseConst.bookingTime: "${DateTime.now()}",
          FirebaseConst.bookingType: FirebaseConst.bookingWait
        }).then((value) {
          int rand = Random().nextInt(60000) * 345;
          notify.doc("$rand").set({
            FirebaseConst.notifyId: "$rand",
            FirebaseConst.notifyReciverId: workerId,
            FirebaseConst.notifyTitle: "استلمت طلب عمل",
            FirebaseConst.notifyText: "ارسل إليك $senderName طلب عمل",
            FirebaseConst.notifyTime: "${DateTime.now()}"
          });
          Get.offAllNamed(AppRoutes.bookingsccess);
        });
      }
    });
  }

  static pickedImageFunction({required XFile? imagePicked}) async {
    late File file;
    Get.back();
    AppFunctions.lodingDailog();
    var imageName = path.basename(imagePicked!.path);
    imageName = "$imageName${Random().nextInt(10000291)}";
    if (imagePicked != null) {
      file = File(imagePicked.path);
      var firebaseUploadImage =
          FirebaseStorage.instance.ref("images/work/$imageName");
      await firebaseUploadImage.putFile(file).then((p0) async {
        String imageUrl = await firebaseUploadImage.getDownloadURL();
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection(FirebaseConst.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(FirebaseConst.workerImages);
        String randId = Random().nextInt(1002134).toString();
        collectionReference.doc(randId).set({
          FirebaseConst.imageId: randId,
          FirebaseConst.imageTime: "${DateTime.now()}",
          FirebaseConst.imageUrl: imageUrl
        }).then((value) {
          Get.back();
          Get.snackbar("", "تم اضافة الصورة بنجاح");
        });
      });
    } else {
      Get.snackbar("", "لم تقوم باختيار صورة");
    }
  }

  static updateDataWithTransactionAndSendNotifications(
      {required DocumentReference documentReference,
      required Map<String, dynamic> data,
      required reciverNotificationId,
      required String workername,
      required String type}) async {
    String yesText = "تم قبول طلب العمل الذي ارسلته الى $workername";
    String notText = "تم رفض الطلب الذي ارسلته الى $workername";
    FirebaseFirestore.instance.runTransaction((transaction) async {
      var docsnapshot = await transaction.get(documentReference);
      if (docsnapshot.exists) {
        documentReference.update(data);
      }
    }).then((value) {
      if (type == FirebaseConst.agreeBooking) {
        addNotifications(
            toId: reciverNotificationId, text: yesText, title: "تم قبول الطلب");
      } else {
        addNotifications(
            toId: reciverNotificationId, text: notText, title: "تم رفض الطلب");
      }
      Get.back();
    });
  }

  static addNotifications(
      {required String toId, required String text, required String title}) {
    AppFunctions.lodingDailog();
    int id = Random().nextInt(6000092);
    notify.doc("$id").set({
      FirebaseConst.notifyId: id,
      FirebaseConst.notifyReciverId: toId,
      FirebaseConst.notifyText: text,
      FirebaseConst.notifyTitle: title,
      FirebaseConst.notifyTime: "${DateTime.now()}"
    }).then((value) {
      Get.snackbar("", "تمت العملية",
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
    });
    Get.back();
  }

  static loginWithEmail(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        sharedPreferences.setString(AppConst.userPass, password);
        
        Get.offAllNamed(AppRoutes.checkScreen);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.back();
        Get.defaultDialog(
            content: Text(
              AppStrings.userNotFound,
              style: AppStyles.textStyleColor(color: Colors.black, size: 15),
              textAlign: TextAlign.center,
            ),
            title: "Error",
            titleStyle: AppStyles.textBoldStyle(),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppStrings.ok,
                    style: AppStyles.textStyleColor(
                        color: AppColor.appMainColor, size: 12),
                  )),
            ]);
      } else if (e.code == "wrong-password") {
        Get.back();
        Get.defaultDialog(
            content: Text(
              AppStrings.wrongPassword,
              style: AppStyles.textStyleColor(color: Colors.black, size: 15),
              textAlign: TextAlign.center,
            ),
            title: "Error",
            titleStyle: AppStyles.textBoldStyle(),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppStrings.ok,
                    style: AppStyles.textStyleColor(
                        color: AppColor.appMainColor, size: 12),
                  )),
            ]);
      }
    }
  }

  static getOneColumn({required String id, required String column}) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection(column).doc(id);
    var data = await userRef.get();
    return data.data();
  }

  static addToCollection(
      {required String collectionName, required Map<String, dynamic> data}) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    AppFunctions.lodingDailog();
    collectionReference.add(data).then((value) {
      Get.back();
      Get.snackbar("", AppStrings.addSeccess,
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    });
  }

  static createAccountWithEmailAndPassword(
      {required String email,
      required String passwrd,
      required String colectionName,
      required String name,
      required String phone,
      required String discription,
      required bool isworker,
      required String location,
      required String selectWork}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: passwrd,
      );
      String? userToken = await credential.user!.getIdToken();
      if (credential.user!.uid.isNotEmpty) {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection(colectionName);
        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot documentSnapshot = await transaction
              .get(collectionReference.doc(credential.user!.uid));
          if (documentSnapshot.exists) {
            Get.defaultDialog(
                title: "",
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.error,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      AppStrings.userFound,
                      style: AppStyles.textBoldStyle(),
                    )
                  ],
                ));
          } else {
            collectionReference.doc(credential.user!.uid).set({
              FirebaseConst.userName: name,
              FirebaseConst.userId: credential.user!.uid,
              FirebaseConst.userPhone: phone,
              FirebaseConst.userDis: discription,
              FirebaseConst.userToken: userToken,
              FirebaseConst.userAdmin: false,
              FirebaseConst.userCanEnter: true,
              FirebaseConst.userPay: true,
              FirebaseConst.userLat: 0.0,
              FirebaseConst.userLong: 0.0,
              FirebaseConst.userIsWorker: isworker == true ? true : false,
              FirebaseConst.userProfileImage: AppConst.defultImageUrl,
              FirebaseConst.userRating: FirebaseConst.defultRating,
              FirebaseConst.userState: location,
              FirebaseConst.userWorkType:
                  isworker == false ? FirebaseConst.normalUser : selectWork,
            }).then((value) async {
              var userData = await getOneColumn(
                  id: credential.user!.uid, column: colectionName);
              sharedPreferences.setString(AppConst.userPass, passwrd);
              sharedPreferences.setBool(
                  UserConst.userIsworker, userData[FirebaseConst.userIsWorker]);
              sharedPreferences.setString(
                  UserConst.userName, userData[FirebaseConst.userName]);
              credential.user!.sendEmailVerification();
              Get.back();
              Get.offNamed(AppRoutes.verifyCode);
            });
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.defaultDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppStrings.ok,
                    style: AppStyles.textStyleColor(
                        color: AppColor.appMainColor, size: 12),
                  )),
            ],
            content: Text(
              AppStrings.passwordWeak,
              style: AppStyles.textStyleColor(color: Colors.black, size: 15),
              textAlign: TextAlign.center,
            ),
            title: AppStrings.error,
            titleStyle:
                AppStyles.textBoldStyleColor(color: Colors.black, size: 18));
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.defaultDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppStrings.ok,
                    style: AppStyles.textStyleColor(
                        color: AppColor.appMainColor, size: 12),
                  )),
            ],
            content: Text(
              AppStrings.emailUsed,
              textAlign: TextAlign.center,
              style: AppStyles.textStyleColor(color: Colors.black, size: 15),
            ),
            title: AppStrings.error,
            titleStyle:
                AppStyles.textBoldStyleColor(color: Colors.black, size: 18));
      }
    } catch (e) {
      Get.defaultDialog(content: Text(e.toString()));
    }
  }

  static addDataToColections(
      {required String colectionName,
      required UserCredential userCredential,
      required Map<String, dynamic> data}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(colectionName);
    //String? userToken = await userCredential.user!.getIdToken();

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction
          .get(collectionReference.doc(userCredential.user!.uid));
      if (documentSnapshot.exists) {
        Get.defaultDialog(
            title: "",
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.error,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
                Text(
                  AppStrings.userFound,
                  style: AppStyles.textBoldStyle(),
                )
              ],
            ));
      } else {
        collectionReference
            .doc(userCredential.user!.uid)
            .set(data)
            .then((value) async {
          var userData = await getOneColumn(
              id: userCredential.user!.uid, column: FirebaseConst.users);
          sharedPreferences.setBool(
              UserConst.userIsworker, userData[FirebaseConst.userIsWorker]);
          sharedPreferences.setString(
              UserConst.userName, userData[FirebaseConst.userName]);
          userCredential.user!.sendEmailVerification();
          Get.back();

          Get.offNamed(AppRoutes.verifyCode);
        });
      }
    });
  }
}

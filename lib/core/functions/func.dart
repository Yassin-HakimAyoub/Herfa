import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/home/send_money_massage.dart';
import 'package:services/view/widgets/circular_image.dart';

import '../../view/widgets/defult_button.dart';

class AppFunctions {
  static late Position cl;
  static String myLocation = "السودان";
  static changeLocalTime() async {
    await Jiffy.setLocale("ar");
  }

  static Future getLongLate() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
  }

  static updateLocation({required String id}) async {
    late bool service;
    late LocationPermission permission;
    permission = await Geolocator.checkPermission();

    service = await Geolocator.isLocationServiceEnabled();

    if (service == false) {
      Get.defaultDialog(
          title: "الموقع",
          titleStyle:
              AppStyles.textBoldStyleColor(color: Colors.black, size: 18),
          content: Column(
            children: [
              Text(
                "قم بتفعيل خاصية الوصول للموقع",
                style: AppStyles.textStyleColor(color: Colors.black, size: 16),
              )
            ],
          ));
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        try {
          List<Placemark> location = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          FirebaseConst.userColumn.doc(id).update({
            FirebaseConst.userState: "${location[0].locality}",
            FirebaseConst.userLat: position.latitude,
            FirebaseConst.userLong: position.longitude
          });
        } catch (e) {}
      }
    }
  }

  static Future getPosition() async {
    late bool service;
    late LocationPermission permission;
    service = await Geolocator.isLocationServiceEnabled();
    if (service == false) {
      Get.defaultDialog(
          title: "الموقع",
          titleStyle:
              AppStyles.textBoldStyleColor(color: Colors.black, size: 18),
          content: Column(
            children: [
              Text(
                "قم بتفعيل خاصية الوصول للموقع",
                style: AppStyles.textStyleColor(color: Colors.black, size: 16),
              )
            ],
          ));
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        try {
          Position position = await Geolocator.getCurrentPosition();
          List<Placemark> location = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          myLocation = "${location[0].locality}";
        } catch (e) {}
      }
    }
  }

  static myDivider() {
    return Column(
      children: [
        Container(
          height: 40,
          width: 2,
          color: Colors.black38,
        )
      ],
    );
  }

  static countColumnWithPercent(
      {required Stream<QuerySnapshot<Map<String, dynamic>>> strem,
      required String text,
      required Color color,
      required double radius}) {
    return StreamBuilder(
        stream: strem,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                CircularPercentIndicator(
                  radius: radius,
                  animation: true,
                  percent: snapshot.data!.docs.length == 100
                      ? 1.0
                      : snapshot.data!.docs.length / 100,
                  lineWidth: 9.0,
                  animationDuration: 1000,
                  progressColor: color,
                  center: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${snapshot.data!.docs.length}"),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: AppStyles.textBoldStyle(),
                      )
                    ],
                  )),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  static countBookingNumbers(
      {required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
      required String text,
      required Color color}) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${snapshot.data!.docs.length}",
                  style: AppStyles.textBoldStyle(),
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Cairo', fontSize: 10, color: color),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static disblayMoneyData(BuildContext context,
      {required String workTime,
      required String money,
      required String commint,
      required Function()? click}) {
    Get.defaultDialog(
        title: "",
        content: SizedBox(
          width: screenWidth(context) - 10,
          height: screenHeight(context) * 0.55,
          child: Column(
            children: [
              Text(
                "الفاتورة",
                style: AppStyles.textBoldStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "وقت الحضور للعمل :",
                    style: AppStyles.subTitelStyle(),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Jiffy.parse(workTime).fromNow(),
                    style: AppStyles.textBoldStyle(),
                  )
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "المبلغ : ",
                        style: AppStyles.subTitelStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Center(
                    child: Text(
                      "$money جنيه سوداني",
                      textAlign: TextAlign.center,
                      style: AppStyles.textBoldStyle(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "تعليق : ",
                        style: AppStyles.subTitelStyle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    child: Text(
                      commint,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleColor(
                          color: Colors.black, size: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              defultButton(text: "تم", click: click)
            ],
          ),
        ));
  }

  static void lodingDailog() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColor.appMainColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.loading,
              style: AppStyles.textBoldStyle(),
            ),
          ],
        ));
  }
}

var booked = FirebaseFirestore.instance.collection(FirebaseConst.booking);
var notify = FirebaseFirestore.instance.collection(FirebaseConst.notification);

WriteBatch batch = FirebaseFirestore.instance.batch();

displayData(BuildContext context,
    {required String name,
    required String ourservices,
    required String location,
    required String id,
    required String senderId,
    required int disBetween,
    required String type,
    required String problemText}) {
  Get.defaultDialog(
      title: "تفاصيل الطلب",
      titleStyle: AppStyles.titelStyle(),
      content: SizedBox(
        width: screenWidth(context) - 10,
        height: screenHeight(context) * 0.55,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(AppConst.defultImageUrl),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("الخدمة",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: Colors.black54)),
                      Text(
                        ourservices,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("يبعد عنك",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: Colors.black54)),
                      Text("${disBetween} متر",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("شرح المشكلة", //وقت الحضور
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: Colors.black54)),
                    ],
                  ),
                  Text(
                    problemText,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text("الموقع", // المبلغ
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          color: Colors.black54))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  Text(location,
                      style: const TextStyle(fontFamily: "Cairo", fontSize: 13))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              type == FirebaseConst.bookingWait
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Get.back();
                            AppFunctions.lodingDailog();
                            FirebaseFunctions
                                .updateDataWithTransactionAndSendNotifications(
                                    documentReference: booked.doc(id),
                                    reciverNotificationId: senderId,
                                    type: FirebaseConst.agreeBooking,
                                    workername: sharedPreferences
                                        .getString(AppConst.userName)!,
                                    data: {
                                  FirebaseConst.bookingType:
                                      FirebaseConst.bookingOk,
                                  FirebaseConst.bookingRead: true
                                });
                          },
                          color: Colors.blue,
                          child: const Text(
                            "قبول الطلب",
                            style: TextStyle(
                                fontFamily: 'Cairo', color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Get.back();
                            AppFunctions.lodingDailog();
                            FirebaseFunctions
                                .updateDataWithTransactionAndSendNotifications(
                                    documentReference: booked.doc(id),
                                    data: {
                                      FirebaseConst.bookingType:
                                          FirebaseConst.bookingNo,
                                      FirebaseConst.bookingRead: true
                                    },
                                    reciverNotificationId: senderId,
                                    workername: sharedPreferences
                                        .getString(AppConst.userName)!,
                                    type: FirebaseConst.disagreeBooking);
                          },
                          color: Colors.green,
                          child: const Text(
                            "رفض الطلب",
                            style: TextStyle(
                                fontFamily: 'Cairo', color: Colors.white),
                          ),
                        )
                      ],
                    )
                  : type == FirebaseConst.bookingOk
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "تم قبول الطلب",
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: Colors.green),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SendMoneyMassage(
                                            userId: senderId,
                                            name: name,
                                          )));
                                },
                                child: const Text(
                                  "ارسال فاتورة",
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      color: Colors.blue),
                                ))
                          ],
                        )
                      : const Text("تم رفض الطلب",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 20,
                            color: Colors.red,
                          )),
            ],
          ),
        ),
      ));
}

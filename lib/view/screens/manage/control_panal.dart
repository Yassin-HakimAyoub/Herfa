import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/view/screens/manage/manage_bookings.dart';
import 'package:services/view/screens/manage/manage_money.dart';
import 'package:services/view/screens/manage/manage_users.dart';
import 'package:services/core/constans/enums.dart';

class ControlPanal extends StatelessWidget {
  ControlPanal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "لوحت التحكم",
            style: AppStyles.textBoldStyle(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  SendNotificationsForUsers(id: AppConst.AllUsers);
                },
                icon: Icon(Icons.send)),
            IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.manageNotifications);
                },
                icon: Icon(Icons.notifications))
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  viewUserAndWorkerNumers(context,
                      stream: FirebaseConst.userColumn
                          .where(FirebaseConst.userIsWorker, isEqualTo: false)
                          .snapshots(),
                      text: "المستخدمين",
                      color: Colors.blue,
                      userTypes: UserTypes.USER),
                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: 2,
                        color: Colors.black38,
                      )
                    ],
                  ),
                  viewUserAndWorkerNumers(context,
                      stream: FirebaseConst.userColumn
                          .where(FirebaseConst.userIsWorker, isEqualTo: true)
                          .snapshots(),
                      text: "العمال",
                      color: Colors.green,
                      userTypes: UserTypes.WORKER),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ManageBookings()));
                    },
                    child: AppFunctions.countColumnWithPercent(
                        strem: FirebaseConst.bookingColumn.snapshots(),
                        text: "الحجوزات",
                        color: Colors.blue,
                        radius: 70),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ManageMoney()));
                    },
                    child: AppFunctions.countColumnWithPercent(
                        strem: FirebaseConst.moneyColumn.snapshots(),
                        text: "الفواتير",
                        color: Colors.green,
                        radius: 60),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppFunctions.countBookingNumbers(
                      stream: FirebaseConst.bookingColumn
                          .where(FirebaseConst.bookingType,
                              isEqualTo: FirebaseConst.bookingOk)
                          .snapshots(),
                      text: "الحجوزات المقبولة",
                      color: Colors.blue),
                  AppFunctions.myDivider(),
                  AppFunctions.countBookingNumbers(
                      stream: FirebaseConst.bookingColumn
                          .where(FirebaseConst.bookingType,
                              isEqualTo: FirebaseConst.bookingWait)
                          .snapshots(),
                      text: "الحجوزات المنتظرة",
                      color: Colors.green),
                  AppFunctions.myDivider(),
                  AppFunctions.countBookingNumbers(
                      stream: FirebaseConst.bookingColumn
                          .where(FirebaseConst.bookingType,
                              isEqualTo: FirebaseConst.bookingNo)
                          .snapshots(),
                      text: "الحجوزات المرفوضة",
                      color: Colors.red),
                ],
              )
            ],
          ),
        ));
  }
}

viewUserAndWorkerNumers(BuildContext context,
    {required Stream<QuerySnapshot<Map<String, dynamic>>> stream,
    required String text,
    required Color color,
    required UserTypes userTypes}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ManageUsers(types: userTypes)));
    },
    child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: color,
                ),
                Text(
                  "${snapshot.data!.docs.length}",
                  style: AppStyles.textBoldStyle(),
                ),
                Text(
                  text,
                  style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/designs/view_money_user_design.dart';
import 'package:services/view/screens/designs/view_money_worker_design.dart';

// ignore: must_be_immutable
class ViewMoneyData extends StatelessWidget {
  CollectionReference userMoneyMassage =
      FirebaseFirestore.instance.collection(FirebaseConst.moneyCollection);

  ViewMoneyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("الفواتير",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: userMoneyMassage
                .where(
                    sharedPreferences.getBool(UserConst.userIsworker) == true
                        ? FirebaseConst.moneyWorkerId
                        : FirebaseConst.moneyUserId,
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("خطاء"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return sharedPreferences
                                  .getBool(UserConst.userIsworker) ==
                              true
                          ? ViewMoneyWorkerDesign(
                              click: () {
                                AppFunctions.disblayMoneyData(context,
                                    workTime: snapshot.data!.docs[index]
                                        .get(FirebaseConst.moneyWorkTime),
                                    money: snapshot.data!.docs[index]
                                        .get(FirebaseConst.moneyText),
                                    commint: snapshot.data!.docs[index]
                                        .get(FirebaseConst.moneyCommint),
                                    click: () {
                                  Get.back();
                                });
                              },
                              username: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyWorkerName),
                              userId: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyUserId),
                              time: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyTime))
                          : ViewMoneyUserDesign(
                              id: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyId),
                              commint: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyCommint),
                              worktime: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyWorkTime),
                              workerName: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyWorkerName),
                              workerId: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyWorkerId),
                              type: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyRating),
                              text: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyText),
                              userId: snapshot.data!.docs[index]
                                  .get(FirebaseConst.moneyUserId),
                              time:
                                  "${snapshot.data!.docs[index].get(FirebaseConst.moneyTime)}");
                    });
              } else if (!snapshot.hasData) {
                Center(
                    child: Text(
                  "لا توجد فواتير",
                  style: Theme.of(context).textTheme.displaySmall,
                ));
              }
              return Container();
            }));
  }
}

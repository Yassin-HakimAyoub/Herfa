import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/worker/worker_profile.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/defult_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class SendMoneyMassage extends StatefulWidget {
  String userId;
  String name;
  SendMoneyMassage({super.key, required this.userId, required this.name});

  @override
  State<SendMoneyMassage> createState() =>
      _SendMonyState(userId: userId, name: name);
}

class _SendMonyState extends State<SendMoneyMassage> {
  String userId;
  String name;
  _SendMonyState({required this.userId, required this.name});
  TextEditingController moneyController = TextEditingController();
  TextEditingController commintController = TextEditingController();
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();

  DateTime? selectedTime = DateTime.now();
  int randId = Random().nextInt(834539) * 292;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ارسال الفاتورة",
          style: AppStyles.titelStyle(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                SizedBox(width: 30 , height: 30,child: CircleImage(id: userId, radius: 30 , width: 30 , height: 30,)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: AppStyles.textBoldStyle(),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "اضعط لتحديد وقت الحضور الى العمل ",
                        style: AppStyles.subTitelStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    selectedTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030));
                    setState(() {});
                  },
                  child: Text(
                    Jiffy.parse(selectedTime.toString()).yMMMEd,
                    style: AppStyles.titelStyle(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: fromstate,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: myTextEditproblem(context,
                              maxL: 10,
                              hint: "ادخل المبلغ بالجنيه السوداني",
                              controller: moneyController,
                              problem: " المبلغ"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: myTextEditproblem(context,
                              hint: "اكتب تعليقا",
                              maxL: 100,
                              controller: commintController,
                              problem: " تعليق"),
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            defultButton(
                text: "ارسال الفاتورة",
                click: () {
                  if (fromstate.currentState!.validate()) {
                    CollectionReference sendMoneycollection = FirebaseFirestore
                        .instance
                        .collection(FirebaseConst.moneyCollection);
                    int rand = Random().nextInt(1001293);
                    AppFunctions.lodingDailog();
                    sendMoneycollection.doc("$rand").set({
                      FirebaseConst.moneyText: moneyController.text,
                      FirebaseConst.moneyUserId: userId,
                      FirebaseConst.moneyWorkerName:
                          sharedPreferences.getString(AppConst.userName),
                      FirebaseConst.moneyTime: "${DateTime.now()}",
                      FirebaseConst.moneyId: "$rand",
                      FirebaseConst.moneyWorkTime: "$selectedTime",
                      FirebaseConst.moneyCommint: commintController.text,
                      FirebaseConst.moneyRating:
                          FirebaseConst.moneyRatingTypeWait,
                      FirebaseConst.moneyWorkerId:
                          FirebaseAuth.instance.currentUser!.uid,
                      FirebaseConst.moneyRead: false
                    }).then((value) {
                      Get.back();
                      Get.back();
                    });
                  } else {
                    Get.defaultDialog(
                        title: "",
                        content: const Center(
                          child: Text("خطاء"),
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }
}

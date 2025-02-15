import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/worker/worker_profile.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/defult_button.dart';

// ignore: must_be_immutable
class RatingMe extends StatefulWidget {
  String workerId;
  String moneyId;
  String workerName;
  RatingMe(
      {super.key,
      required this.workerId,
      required this.moneyId,
      required this.workerName});

  @override
  State<RatingMe> createState() => _RatingMeState(
      workerId: workerId, moneyId: moneyId, workerName: workerName);
}

class _RatingMeState extends State<RatingMe> {
  TextEditingController ratingMoneymassageController = TextEditingController();
  String workerId;
  double starsRating = 0.0;
  String moneyId;
  String workerName;
  CollectionReference collectionMoney =
      FirebaseFirestore.instance.collection(FirebaseConst.moneyCollection);
  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection(FirebaseConst.users);
  CollectionReference collectionRatings =
      FirebaseFirestore.instance.collection(FirebaseConst.rating);
  _RatingMeState(
      {required this.workerId,
      required this.moneyId,
      required this.workerName});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تقييم العامل",
          style: AppStyles.titelStyle(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleImage(
                      id: workerId,
                      radius: 80,
                      width: 80,
                      height: 80,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  workerName,
                  style: AppStyles.textBoldStyle(),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "تقييم العامل",
                    style: AppStyles.subTitelStyle(),
                  ),
                ),
                RatingBar(
                    allowHalfRating: false,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star_outlined,
                          color: Colors.yellow,
                        ),
                        half: const Icon(Icons.star_half_outlined),
                        empty: Icon(
                          Icons.star_outlined,
                          color: Colors.grey[200],
                        )),
                    onRatingUpdate: (rating) {
                      setState(() {
                        starsRating = rating;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: screenWidth(context) - 20,
                  child: Form(
                      child: myTextEditproblem(context,
                          maxL: 200,
                          hint: "اكتب شئ عن العامل",
                          controller: ratingMoneymassageController,
                          problem: "")),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            defultButton(
                text: "تقييم",
                click: () async {
                  if (ratingMoneymassageController.text.isNotEmpty) {
                    AppFunctions.lodingDailog();
                    collectionMoney.doc(moneyId).update({
                      FirebaseConst.moneyRating:
                          FirebaseConst.moneyRatingTypeYes,
                    }).then((value) async {
                      collectionRatings.add({
                        FirebaseConst.ratingStars: starsRating.toInt(),
                        FirebaseConst.ratingText:
                            ratingMoneymassageController.text,
                        FirebaseConst.ratingWorkerId: workerId,
                        FirebaseConst.ratingSenderId:
                            FirebaseAuth.instance.currentUser!.uid,
                        FirebaseConst.ratingSenderName:
                            sharedPreferences.getString(AppConst.userName),
                      }).then((value) async {
                        var workerData = await FirebaseFunctions.getOneColumn(
                            id: workerId, column: FirebaseConst.users);
                        int oldworkerRating =
                            workerData[FirebaseConst.userRating];
                        int newRating = oldworkerRating + starsRating.toInt();
                        collectionUser.doc(workerId).update({
                          FirebaseConst.userRating: newRating,
                        }).then((value) {
                          FirebaseFunctions.addNotifications(
                              title: "تم تقييم عملك",
                              toId: workerId,
                              text:
                                  " لقد قام ${sharedPreferences.getString(AppConst.userName)} بتقييم عملك ${starsRating} نجوم");
                        });
                      });
                    });

                    Get.back();
                    Get.back();
                    Get.snackbar("", "تم تقييم العامل بنجاح",
                        backgroundColor: AppColor.appMainColor);
                  }
                })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/view/screens/home/rating_me.dart';

// ignore: must_be_immutable
class ViewMoneyUserDesign extends StatelessWidget {
  String workerId, workerName, text, userId, type, time,commint, id, worktime;
  ViewMoneyUserDesign(
      {super.key,
      required this.workerId,
      required this.workerName,
      required this.text,
      required this.worktime,
      required this.userId,
      required this.id,
      required this.type,
    required this.commint,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "ارسل إليك $workerName فاتورة العمل ",
                  style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                )
              ],
            ),
            const Text(
              "الرجاء مراجعت الفاتورة",
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 12, color: Colors.black87),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    AppFunctions.disblayMoneyData(context,
                        workTime: worktime,
                        
                        commint: commint,
                        money: text, click: () {
                      FirebaseConst.moneyColumn
                          .doc(id)
                          .update({FirebaseConst.moneyRead: true});
                      Get.back();
                    });
                  },
                  child: const Text(
                    "عرض الفاتورة",
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: 14, color: Colors.blue),
                  ),
                ),
                type == FirebaseConst.ratingWait
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RatingMe(
                                    workerId: workerId,
                                    moneyId: id,
                                    workerName: workerName,
                                  )));
                        },
                        child: const Text(
                          "تقييم العامل",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              color: Colors.green),
                        ),
                      )
                    : const Text("تم التقييم",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.blue)),
              ],
            ),
            Row(children: [
              Text(
                Jiffy.parse(time).fromNow(),
                style: const TextStyle(
                    fontFamily: 'Cairo', fontSize: 12, color: Colors.black54),
              )
            ])
          ],
        ),
      ),
    );
  }
}

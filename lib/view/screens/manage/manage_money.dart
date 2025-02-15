import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/func.dart';

class ManageMoney extends StatefulWidget {
  const ManageMoney({super.key});

  @override
  State<ManageMoney> createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ادارة الفواتير",
          style: AppStyles.textBoldStyle(),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseConst.moneyColumn.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (dirction) {
                            FirebaseConst.moneyColumn
                                .doc(
                                    "${snapshot.data!.docs[index].get(FirebaseConst.moneyId)}")
                                .delete();
                            setState(() {});
                          },
                          child: Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                " لقد تم ارسال فاتورة الى ${snapshot.data!.docs[index].get(FirebaseConst.moneyWorkerName)}",
                                style: AppStyles.textStyleColor(
                                    color: Colors.black, size: 12),
                              ),
                              subtitle: Text(
                                Jiffy.parse(snapshot.data!.docs[index]
                                        .get(FirebaseConst.moneyTime))
                                    .fromNow(),
                                style: AppStyles.textStyleColor(
                                    color: Colors.black, size: 10),
                              ),
                              onTap: () {
                                AppFunctions.disblayMoneyData(
                                  context,
                                  workTime: snapshot.data!.docs[index]
                                      .get(FirebaseConst.moneyWorkTime),
                                  money: snapshot.data!.docs[index]
                                      .get(FirebaseConst.moneyText),
                                  click: () {
                                    Get.back();
                                  },
                                  commint: snapshot.data!.docs[index]
                                      .get(FirebaseConst.moneyCommint),
                                );
                              },
                            ),
                          ),
                        );
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}

/*

IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "حذف الفاتورة",
                                      titleStyle: AppStyles.textBoldStyle(),
                                      content: Column(
                                        children: [
                                          Text(
                                            "هل تريد حذف هذه الفاتورة ؟",
                                            textAlign: TextAlign.center,
                                            style: AppStyles.textStyle(),
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseConst.moneyColumn
                                                        .doc(snapshot
                                                            .data!.docs[index]
                                                            .get(FirebaseConst
                                                                .moneyId))
                                                        .delete();
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    "نعم",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    "لا",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Cairo',
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
 */

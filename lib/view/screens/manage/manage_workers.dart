import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/view/screens/worker/worker_images.dart';
import 'package:services/view/screens/worker/worker_ratinngs.dart';
import 'package:services/view/widgets/circular_image.dart';

class ManageWorkers extends StatefulWidget {
  String name;
  String id;
  ManageWorkers({super.key, required this.id, required this.name});

  @override
  State<ManageWorkers> createState() => _ManageWorkersState(id: id, name: name);
}

class _ManageWorkersState extends State<ManageWorkers>
    with SingleTickerProviderStateMixin {
  String id;
  String name;
  late final TabController controller;

  _ManageWorkersState({required this.id, required this.name});

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "العامل",
          style: AppStyles.textStyle(),
        ),
        bottom: TabBar(controller: controller, tabs: const [
          Tab(
            child: Text(
              "عن المقدم",
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.blue, fontSize: 12),
            ),
          ),
          Tab(
            child: Text(
              "القيمات",
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.blue, fontSize: 12),
            ),
          ),
          Tab(
            child: Text(
              "اعمال السابقة",
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.blue, fontSize: 12),
            ),
          )
        ]),
      ),
      body: TabBarView(controller: controller, children: [
        FirestManage(id: id),
        WorkerRatings(workerId: id),
        WorkerImages(
          id: id,
          isAdmin: true,
        )
      ]),
    );
  }
}

// ignore: must_be_immutable
class FirestManage extends StatefulWidget {
  String id;
  FirestManage({super.key, required this.id});

  @override
  State<FirestManage> createState() => _FirestManageState(id: id);
}

class _FirestManageState extends State<FirestManage> {
  String id;
  _FirestManageState({required this.id});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder(
            stream: FirebaseConst.userColumn
                .where(FirebaseConst.userIsWorker, isEqualTo: true)
                .where(FirebaseConst.userId, isEqualTo: id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox( height: 80 , width: 80,child: CircleImage(id: id, radius: 60 , height: 80 , width: 80)),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${snapshot.data!.docs[index].get(FirebaseConst.userName)}",
                                style: AppStyles.textBoldStyle(),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${snapshot.data!.docs[index].get(FirebaseConst.userWorkType)}",
                                style: AppStyles.textStyle(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AppFunctions.countColumnWithPercent(
                                  strem: FirebaseConst.bookingColumn
                                      .where(FirebaseConst.bookingWorkerId,
                                          isEqualTo: id)
                                      .snapshots(),
                                  text: "الحجوزات\n المستلمة",
                                  color: Colors.blue,
                                  radius: 60),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 40,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    "${snapshot.data!.docs[index].get(FirebaseConst.userRating)} \n التقيمات",
                                    textAlign: TextAlign.center,
                                    style: AppStyles.textBoldStyle(),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Switch(
                                      value: snapshot.data!.docs[index]
                                          .get(FirebaseConst.userAdmin),
                                      onChanged: (value) {
                                      
                                        setState(() {
                                          FirebaseConst.userColumn
                                              .doc(id)
                                              .update({
                                            FirebaseConst.userAdmin: value
                                          }).then((value) {
                                            Get.snackbar(
                                                "", "تمت العملية بنجاح");
                                          });
                                        });
                                      }),
                                  Text(
                                    "ادمن",
                                    style: AppStyles.textStyle(),
                                  )
                                ],
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
                                      .where(FirebaseConst.bookingWorkerId,
                                          isEqualTo: id)
                                      .where(FirebaseConst.bookingType,
                                          isEqualTo: FirebaseConst.bookingOk)
                                      .snapshots(),
                                  text: "الحجوزات المقبولة",
                                  color: Colors.blue),
                              AppFunctions.myDivider(),
                              AppFunctions.countBookingNumbers(
                                  stream: FirebaseConst.bookingColumn
                                      .where(FirebaseConst.bookingWorkerId,
                                          isEqualTo: id)
                                      .where(FirebaseConst.bookingType,
                                          isEqualTo: FirebaseConst.bookingWait)
                                      .snapshots(),
                                  text: "الحجوزات المنتظرة",
                                  color: Colors.green),
                              AppFunctions.myDivider(),
                              AppFunctions.countBookingNumbers(
                                  stream: FirebaseConst.bookingColumn
                                      .where(FirebaseConst.bookingWorkerId,
                                          isEqualTo: id)
                                      .where(FirebaseConst.bookingType,
                                          isEqualTo: FirebaseConst.bookingNo)
                                      .snapshots(),
                                  text: "الحجوزات المرفوضة",
                                  color: Colors.red),
                            ],
                          )
                        ],
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

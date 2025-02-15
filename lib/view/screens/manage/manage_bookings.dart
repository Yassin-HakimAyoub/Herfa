import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/size_func.dart';

class ManageBookings extends StatefulWidget {
  const ManageBookings({super.key});

  @override
  State<ManageBookings> createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageBookings> {
  @override
  Widget build(BuildContext context) {
    var bookingData =
        FirebaseFirestore.instance.collection(FirebaseConst.booking);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ادارة الطلبات",
          style: AppStyles.textBoldStyle(),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: bookingData.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            bookingData
                                .doc(
                                    "${snapshot.data!.docs[index].get(FirebaseConst.bookingId)}")
                                .delete();
                            setState(() {});
                          },
                          child: Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                " لقد تم ارسال حجز الى ${snapshot.data!.docs[index].get(FirebaseConst.bookingWorkerName)}",
                                style: AppStyles.textStyleColor(
                                    color: Colors.black, size: 15),
                              ),
                              subtitle: snapshot.data!.docs[index]
                                          .get(FirebaseConst.bookingType) ==
                                      FirebaseConst.bookingOk
                                  ? Text(
                                      "تم قبول الطلب",
                                      style: AppStyles.subTitelStyle(),
                                    )
                                  : snapshot.data!.docs[index]
                                              .get(FirebaseConst.bookingType) ==
                                          FirebaseConst.bookingNo
                                      ? Text(
                                          "تم رفض الطلب",
                                          style: AppStyles.subTitelStyle(),
                                        )
                                      : Text(
                                          "في الانتظار",
                                          style: AppStyles.subTitelStyle(),
                                        ),
                              onTap: () {
                                displayBookingmanageData(
                                    context: context,
                                    between: snapshot.data!.docs[index].get(
                                        FirebaseConst.bookingdistanceBetween),
                                    workerId: snapshot.data!.docs[index]
                                        .get(FirebaseConst.bookingWorkerId),
                                    workerName: snapshot.data!.docs[index]
                                        .get(FirebaseConst.bookingWorkerName),
                                    services: snapshot.data!.docs[index]
                                        .get(FirebaseConst.bookingService),
                                    location: snapshot.data!.docs[index]
                                        .get(FirebaseConst.bookingLocation),
                                    problemText: snapshot.data!.docs[index]
                                        .get(FirebaseConst.bookingText));
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

displayBookingmanageData(
    {required BuildContext context,
    required String workerName,
    required String services,
    required String workerId,
    required String location,
    required int between,
    required String problemText}) {
  Get.defaultDialog(
      title: "تفاصيل الطلب",
      titleStyle: AppStyles.titelStyle(),
      content: SizedBox(
        width: screenWidth(context) - 10,
        height: screenHeight(context) * 0.55,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    workerName,
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
                        services,
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
                      
                           Text("${between} متر",
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
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
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
            ],
          ),
        ),
      ));
}

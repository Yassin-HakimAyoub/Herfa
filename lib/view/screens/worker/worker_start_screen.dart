import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/drawar.dart';
import 'package:services/view/screens/designs/worker_start_loading.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/rating.dart';


class workerStartScreen extends StatefulWidget {
  const workerStartScreen({super.key});

  @override
  State<workerStartScreen> createState() => _workerStartScreenState();
}

class _workerStartScreenState extends State<workerStartScreen> {
  bool isAdmin = true;

  getData() async {
    var data = await FirebaseFunctions.getOneColumn(
        id: FirebaseAuth.instance.currentUser!.uid,
        column: FirebaseConst.users);
    isAdmin = data[FirebaseConst.userAdmin];
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> getMe =
        FirebaseFirestore.instance.collection(FirebaseConst.users);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppImages.logo2))),
              ),
              Text(
                "حرفة",
                style:
                    AppStyles.textBoldStyleColor(color: Colors.black, size: 10),
              )
            ],
          ),
        ],
        title: Text(
          "الرئيسية",
          style: AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawar(context,
          types: UserTypes.WORKER,
          name: 'SECO',
          email: "yassinhakim2001@gmail.com"),
      floatingActionButton: StreamBuilder(
          stream: FirebaseConst.userColumn
              .where(FirebaseConst.userId,
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs[0].get(FirebaseConst.userAdmin) == true
                  ? FloatingActionButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.controlPanal);
                      },
                      child: Icon(Icons.manage_accounts),
                    )
                  : Container();
            }
            return Text("");
          }),
      body: StreamBuilder<QuerySnapshot>(
          stream: getMe
              .where(FirebaseConst.userId,
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: screenHeight(context) * 0.20,
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: CircleImage(
                                      height: 90,
                                      width: 90,
                                      id: snapshot.data!.docs[index]
                                          .get(FirebaseConst.userId),
                                      radius: 90),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]
                                          .get(FirebaseConst.userName),
                                      style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                    Text(
                                        snapshot.data!.docs[index]
                                            .get(FirebaseConst.userWorkType),
                                        style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 17,
                                            color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: screenWidth(context) / 2,
                                height: 20,
                                child: ListTile(
                                  title: const Text(
                                    "الموقع الحالي",
                                    style: TextStyle(
                                        fontFamily: "Cairo", fontSize: 12),
                                  ),
                                  leading: const Icon(Icons.location_history),
                                  subtitle: Text(AppFunctions.myLocation,
                                      style: const TextStyle(
                                          fontFamily: "Cairo", fontSize: 11)),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth(context) / 2,
                                height: 20,
                                child: ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: const Text(
                                    "الهاتف",
                                    style: TextStyle(
                                        fontFamily: "Cairo", fontSize: 12),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]
                                        .get(FirebaseConst.userPhone),
                                    style: const TextStyle(
                                        fontFamily: "Cairo", fontSize: 11),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context) * 0.08,
                          ),
                          ListTile(
                              title: Text("تقييمك",
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              trailing: Text(
                                  "${snapshot.data!.docs[index].get(FirebaseConst.userRating)}"),
                              subtitle: RatingWidget(
                                context,
                                ratingNum: snapshot.data!.docs[index]
                                    .get(FirebaseConst.userRating),
                              )),
                          SizedBox(
                            height: screenHeight(context) * 0.05,
                          ),
                          ListTile(
                            title: Text("نبزة عن العمل ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            subtitle: Text(
                              snapshot.data!.docs[index]
                                  .get(FirebaseConst.userDis),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Cairo', fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const WorkerStartLoading();
            } else if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "لا توجد معاومات",
                  style: AppStyles.textBoldStyle(),
                ),
              );
            }
            return const Center(
              child: Text(""),
            );
          }),
    );
  }
}

/*
var token = await FirebaseMessaging
                                            .instance
                                            .getToken();
                                            sendNotify(titel: "Yassin hakim", body:"this is my app", token: token!);
                                            
                                        FirebaseNotification
                                            .sendNotificationWithFirebase(
                                                deviceToken: token!,
                                                context: context,
                                                title: "حرب الشغل",
                                                body: "الشغل راني"); 
*/
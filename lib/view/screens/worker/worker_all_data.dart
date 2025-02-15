import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class WorkerAllData extends StatelessWidget {
  String workerId;
  WorkerAllData({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> getWorkerInfo =
        FirebaseFirestore.instance.collection(FirebaseConst.users);
    return StreamBuilder<QuerySnapshot>(
        stream: getWorkerInfo
            .where(FirebaseConst.userId, isEqualTo: workerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(
                            "الحالة",
                            style: AppStyles.textBoldStyle(),
                          ),
                          subtitle: snapshot.data!.docs[index]
                                      .get(FirebaseConst.userIsOnline) ==
                                  FirebaseConst.onLine
                              ? Text(
                                  "نشط الان",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("غير نشط",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold)),
                          leading: CircleAvatar(
                            radius: 5,
                            backgroundColor: snapshot.data!.docs[index]
                                        .get(FirebaseConst.userIsOnline) ==
                                    FirebaseConst.onLine
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            "المهنة",
                            style: AppStyles.textBoldStyleColor(
                                color: Colors.black, size: 14),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]
                                .get(FirebaseConst.userWorkType),
                            style: AppStyles.textStyleColor(
                                color: Colors.black, size: 12),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            "الموقع",
                            style: AppStyles.textBoldStyleColor(
                                color: Colors.black, size: 14),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]
                                .get(FirebaseConst.userState),
                            style: AppStyles.textStyleColor(
                                color: Colors.black, size: 12),
                          ),
                        ),
                      ),
                      Card(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri lauCall = Uri(
                                scheme: "tel",
                                path:
                                    "${snapshot.data!.docs[index].get(FirebaseConst.userPhone)}");
                            await launchUrl(lauCall);
                          },
                          child: ListTile(
                            title: Text(
                              "الهاتف",
                              style: AppStyles.textBoldStyleColor(
                                  color: Colors.black, size: 14),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]
                                  .get(FirebaseConst.userPhone),
                              style: AppStyles.textStyleColor(
                                  color: Colors.black, size: 12),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text(
                            "عن مقدم الخدمة ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${snapshot.data!.docs[index].get(FirebaseConst.userDis)}",
                            style: const TextStyle(
                                fontFamily: 'Cairo', fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

titelDesign(BuildContext context,
    {required double width,
    required String text,
    required IconData iconData,
    required EdgeInsetsGeometry margin,
    required String titel}) {
  return Card(
    margin: margin,
    child: Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(10),
      width: width,
      height: 70,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              titel,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

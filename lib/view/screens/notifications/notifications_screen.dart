import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:jiffy/jiffy.dart';

// ignore: camel_case_types
class notificationScreen extends StatefulWidget {
  const notificationScreen({super.key});

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {
  String yourId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference usersNotificatins =
      FirebaseFirestore.instance.collection(FirebaseConst.notification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: const Text(
          "الاشعارات",
          style: TextStyle(
              fontSize: 20, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: usersNotificatins.where(FirebaseConst.notifyReciverId,
                  whereIn: [
                    FirebaseAuth.instance.currentUser!.uid,
                    AppConst.AllUsers
                  ]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("خطاء"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return notificationDesign(context,
                            title: snapshot.data!.docs[index]
                                .get(FirebaseConst.notifyTitle),
                            text: snapshot.data!.docs[index]
                                .get(FirebaseConst.notifyText),
                            time: snapshot.data!.docs[index]
                                .get(FirebaseConst.notifyTime));
                      });
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    "لا توجد إشعارات",
                    style: Theme.of(context).textTheme.displaySmall,
                  ));
                }
                return Center(
                    child: Text(
                  "لا توجد إشعارات",
                  style: Theme.of(context).textTheme.displaySmall,
                ));
              })),
    );
  }
}

notificationDesign(BuildContext context,
    {required String text, required String time, required String title}) {
  return Card(
    elevation: 0.5,
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.notifications_active_sharp,
              color: Colors.white,
            ),
          ),
          title: Text(
            title,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: screenWidth(context) - 120,
                    child: Text(
                      overflow: TextOverflow.clip,
                      text,
                      textAlign: TextAlign.start,
                      style: AppStyles.textStyleColor(
                          color: Colors.black, size: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Jiffy.parse(time).fromNow(),
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo',
                        color: Colors.black54),
                  )
                ],
              ),
            ],
          ),
        )),
  );
}

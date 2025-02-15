import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/notifications/notifications_screen.dart';

class ManageNotifications extends StatefulWidget {
  const ManageNotifications({super.key});

  @override
  State<ManageNotifications> createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  CollectionReference usersNotificatins =
      FirebaseFirestore.instance.collection(FirebaseConst.notification);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ادارة الاشعارات",
          style: AppStyles.textBoldStyle(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: usersNotificatins.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (dir) {
                              usersNotificatins
                                  .doc(
                                      "${snapshot.data!.docs[index].get(FirebaseConst.notifyId)}")
                                  .delete();
                              setState(() {});
                            },
                            child: notificationDesign(context,
                                title: snapshot.data!.docs[index]
                                    .get(FirebaseConst.notifyTitle),
                                text: snapshot.data!.docs[index]
                                    .get(FirebaseConst.notifyText),
                                time: snapshot.data!.docs[index]
                                    .get(FirebaseConst.notifyTime)));
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Loading();
                }
                return Container();
              })),
    );
  }
}

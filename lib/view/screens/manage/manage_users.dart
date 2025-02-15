import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/view/screens/manage/manage_workers.dart';
import 'package:services/view/widgets/mytextforms.dart';

// ignore: must_be_immutable
class ManageUsers extends StatefulWidget {
  UserTypes types;
  ManageUsers({super.key, required this.types});

  @override
  State<ManageUsers> createState() => _ManageUsersState(types: types);
}

class _ManageUsersState extends State<ManageUsers> {
  UserTypes types;
  bool canEnter = false;
  _ManageUsersState({required this.types});
  @override
  Widget build(BuildContext context) {
    var workerData = FirebaseFirestore.instance.collection(FirebaseConst.users);
    return Scaffold(
      appBar: AppBar(
        title: Text("المستخدمين", style: AppStyles.textBoldStyle()),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: workerData
                  .where(FirebaseConst.userIsWorker,
                      isEqualTo: types == UserTypes.USER ? false : true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return manageUserDesign(
                          id: snapshot.data!.docs[index]
                              .get(FirebaseConst.userId),
                          name: snapshot.data!.docs[index]
                              .get(FirebaseConst.userName),
                          click: () {
                            if (types == UserTypes.USER) {
                            } else if (types == UserTypes.WORKER) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageWorkers(
                                          name: snapshot.data!.docs[index]
                                              .get(FirebaseConst.userName),
                                          id: snapshot.data!.docs[index]
                                              .get(FirebaseConst.userId))));
                            }
                          },
                          button1: TextButton(
                              onPressed: () {
                                if (snapshot.data!.docs[index]
                                        .get(FirebaseConst.userPay) ==
                                    true) {
                                  workerData
                                      .doc(snapshot.data!.docs[index]
                                          .get(FirebaseConst.userId))
                                      .update({FirebaseConst.userPay: false});
                                  setState(() {});
                                } else {
                                  workerData
                                      .doc(snapshot.data!.docs[index]
                                          .get(FirebaseConst.userId))
                                      .update({FirebaseConst.userPay: true});
                                  setState(() {});
                                }
                              },
                              child: snapshot.data!.docs[index]
                                          .get(FirebaseConst.userPay) ==
                                      true
                                  ? const Text(
                                      'مدفوع',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.blue),
                                    )
                                  : const Text(
                                      'ادفع',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.red),
                                    )),
                          button2: TextButton(
                              onPressed: () {
                                if (snapshot.data!.docs[index]
                                        .get(FirebaseConst.userCanEnter) ==
                                    true) {
                                  workerData
                                      .doc(snapshot.data!.docs[index]
                                          .get(FirebaseConst.userId))
                                      .update(
                                          {FirebaseConst.userCanEnter: false});
                                  setState(() {});
                                } else {
                                  workerData
                                      .doc(snapshot.data!.docs[index]
                                          .get(FirebaseConst.userId))
                                      .update(
                                          {FirebaseConst.userCanEnter: true});
                                  setState(() {});
                                }
                              },
                              child: snapshot.data!.docs[index]
                                          .get(FirebaseConst.userCanEnter) ==
                                      true
                                  ? const Text(
                                      'حظر',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.blue),
                                    )
                                  : const Text(
                                      'محظور',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.red),
                                    )),
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}

manageUserDesign({
  required String id,
  required String name,
  required Function() click,
  required Widget button1,
  required Widget button2,
}) {
  return GestureDetector(
    onTap: click,
    child: SizedBox(
      height: 116,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(AppConst.defultImageUrl),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      name,
                      style: AppStyles.textBoldStyleColor(
                          color: Colors.black, size: 14),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      SendNotificationsForUsers(id: id);
                    },
                    icon: Icon(Icons.send))
              ],
            ),
            Row(
              children: [button1, button2],
            )
          ],
        ),
      ),
    ),
  );
}

SendNotificationsForUsers({required String id}) {
  //GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  TextEditingController titelController = TextEditingController();
  TextEditingController notifyController = TextEditingController();

  Get.defaultDialog(
      title: "ارسال اشعار",
      titleStyle: AppStyles.textBoldStyleColor(color: Colors.black, size: 12),
      actions: [],
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: customTextFiled(
                    hinttext: "عنوان الاشعار",
                    valid: (value) {
                      return validInput(
                          value!, 10, 50, AppConst.notificationsvalid);
                    },
                    editingController: titelController,
                    textInputType: TextInputType.text,
                    iconData: Icons.mark_as_unread_sharp,
                    labeltext: "العنوان"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 2),
                child: customTextFiled(
                    hinttext: " الاشعار",
                    valid: (value) {
                      return validInput(
                          value!, 10, 50, AppConst.notificationsvalid);
                    },
                    editingController: notifyController,
                    textInputType: TextInputType.text,
                    iconData: Icons.mark_as_unread_sharp,
                    labeltext: "الاشعار"),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (titelController.text.isNotEmpty &&
                            notifyController.text.isNotEmpty) {
                          FirebaseFunctions.addNotifications(
                              title: "${titelController.text}",
                              toId: id,
                              text: "${notifyController.text}");
                          Get.back();
                        }
                      },
                      child: Text(
                        "أرسال",
                        style: AppStyles.textStyleColor(
                            color: Colors.blue, size: 10),
                      )),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "إلغاء",
                        style: AppStyles.textStyleColor(
                            color: Colors.red, size: 10),
                      )),
                ],
              )
            ],
          ),
        ),
      ));
}

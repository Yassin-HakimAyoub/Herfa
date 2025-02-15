import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/worker/worker_edite_profile.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/defult_button.dart';

// ignore: must_be_immutable
class YourAccount extends StatefulWidget {
  String id;
  UserTypes types;

  YourAccount({super.key, required this.id, required this.types});

  @override
  State<YourAccount> createState() => _YourAccountState(id: id, types: types);
}

class _YourAccountState extends State<YourAccount> {
  String id;
  UserTypes types;
  _YourAccountState({required this.id, required this.types});

  List titels = ["الاسم", "الموقع", "الهاتف"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حسابك",
          style: AppStyles.textBoldStyleColor(color: Colors.black, size: 19),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditeWorkerProfile(
                              id: id,
                              types: types,
                            )));
              },
              child: Text(
                "تعديل",
                style: AppStyles.textStyleColor(
                    color: AppColor.appMainColor, size: 15),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: CircleImage(height: 100, width: 100, id: id, radius: 100)),
          Container(
            alignment: Alignment.center,
            width: screenWidth(context),
            height: screenHeight(context) * 0.40,
            child: StreamBuilder(
                stream: FirebaseConst.userColumn
                    .where(FirebaseConst.userId, isEqualTo: id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                title: Text(
                                  "الاسم",
                                  style: AppStyles.textBoldStyleColor(
                                      color: Colors.black, size: 15),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]
                                      .get(FirebaseConst.userName),
                                  style: AppStyles.textStyleColor(
                                      color: Colors.black, size: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "الموقع",
                                  style: AppStyles.textBoldStyleColor(
                                      color: Colors.black, size: 15),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]
                                      .get(FirebaseConst.userState),
                                  style: AppStyles.textStyleColor(
                                      color: Colors.black, size: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "الهاتف",
                                  style: AppStyles.textBoldStyleColor(
                                      color: Colors.black, size: 15),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]
                                      .get(FirebaseConst.userPhone),
                                  style: AppStyles.textStyleColor(
                                      color: Colors.black, size: 14),
                                ),
                              ),
                            ],
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Loading();
                  }
                  return Container();
                }),
          ),
          defultButton(
              text: "تسجيل خروج",
              click: () {
                Get.defaultDialog(
                    actions: [
                      TextButton(
                          onPressed: () async {
                            AppFunctions.lodingDailog();
                            await FirebaseAuth.instance.signOut().then((value) {
                              Get.back();
                              Get.offAllNamed(AppRoutes.login);
                            });
                          },
                          child: Text(
                            "نعم",
                            style: AppStyles.textStyleColor(
                                color: Colors.red, size: 16),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "لا",
                            style: AppStyles.textStyleColor(
                                color: Colors.blue, size: 16),
                          ))
                    ],
                    title: "تسجيل خروج",
                    titleStyle: AppStyles.textBoldStyle(),
                    content: Column(
                      children: [
                        Text(
                          "هل تريد تسجيل خروج من حسابك ؟",
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyleColor(
                              color: Colors.black, size: 16),
                        )
                      ],
                    ));
              })
        ],
      ),
    );
  }
}

desing(
    {required String name, required String location, required String number}) {
  return Column(
    children: [],
  );
}

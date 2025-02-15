import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/main.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/defult_button.dart';
import 'package:services/view/widgets/mytextforms.dart';
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class EditeWorkerProfile extends StatefulWidget {
  String id;
  UserTypes types;

  EditeWorkerProfile({
    super.key,
    required this.id,
    required this.types,
  });

  @override
  State<EditeWorkerProfile> createState() =>
      _EditeWorkerProfileState(id: id, types: types);
}

class _EditeWorkerProfileState extends State<EditeWorkerProfile> {
  String id;
  UserTypes types;
  _EditeWorkerProfileState({
    required this.id,
    required this.types,
  });
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDis = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  late String selectedWork;
  var workerData = FirebaseFirestore.instance.collection(FirebaseConst.users);
  late String name;
  getAll() async {
    var data = await FirebaseFunctions.getOneColumn(
        id: id, column: FirebaseConst.users);
    name = data[FirebaseConst.userName];
    controllerName.text = data[FirebaseConst.userName];
    controllerDis.text = data[FirebaseConst.userDis];
    controllerPhone.text = data[FirebaseConst.userPhone];
    selectedWork = data[FirebaseConst.userWorkType];
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تعديل الملف الشخصي",
          style: AppStyles.textBoldStyle(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
                key: fromstate,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleImage(
                              id: id,
                              radius: 80,
                              height: 80,
                              width: 80,
                            )),
                      ],
                    ),
                    Visibility(
                      visible: types == UserTypes.USER ? false : true,
                      child: IconButton(
                        onPressed: () async {
                          AppFunctions.lodingDailog();
                          File file;
                          var imagePacker = ImagePicker();
                          late XFile? imagePicked;
                          imagePicked = await imagePacker.pickImage(
                              source: ImageSource.gallery);
                          Get.back();
                          AppFunctions.lodingDailog();
                          var imageName = path.basename(imagePicked!.path);
                          imageName = "$imageName${Random().nextInt(10000291)}";
                          if (imagePicked != null) {
                            file = File(imagePicked.path);
                            var firebaseUploadImage = FirebaseStorage.instance
                                .ref("images/profiles/$name$imageName");
                            await firebaseUploadImage
                                .putFile(file)
                                .then((p0) async {
                              String imageUrl =
                                  await firebaseUploadImage.getDownloadURL();
                              workerData.doc(id).update({
                                FirebaseConst.userProfileImage: imageUrl,
                              }).then((value) {
                                Get.back();
                              });
                            });
                          } else {
                            Get.snackbar("", "لم تقوم باختيار صورة");
                          }
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: EditeTextFormFiteld(
                          context: context,
                          labeltext: "الاسم",
                          hinttext: "ادخل اسمك الجديد",
                          iconData: Icons.person,
                          controller: controllerName,
                          valid: (Value) {
                            return validInput(Value!, 6, 14, AppConst.userName);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: EditeTextFormFiteld(
                          context: context,
                          labeltext: "الهاتف",
                          hinttext: "ادخل رقم الهاتف ",
                          iconData: Icons.person,
                          controller: controllerPhone,
                          valid: (Value) {
                            return validInput(Value!, 10, 12, AppConst.phone);
                          }),
                    ),
                    Visibility(
                      visible: types == UserTypes.USER ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: EditeTextFormFiteld(
                            context: context,
                            labeltext: "نبذة",
                            hinttext: "نبذة عن عملك ",
                            iconData: Icons.person,
                            lines: 8,
                            controller: controllerDis,
                            valid: (Value) {
                              return validInput(
                                  Value!, 25, 200, AppConst.longText);
                            }),
                      ),
                    ),
                    Visibility(
                      visible: types == UserTypes.USER ? false : true,
                      child: Container(
                        height: 68,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black54)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              hint: const Text(AppHints.workHint),
                              validator: (value) =>
                                  validInput(value!, 5, 20, "subject"),
                              items: [
                                AppStrings.buildingServices,
                                AppStrings.cleaningServices,
                                AppStrings.electricServices,
                                AppStrings.fixedElectricServices,
                                AppStrings.hairStyleServices,
                                AppStrings.installAirConditionServices,
                                AppStrings.installCctvServices,
                                AppStrings.installSolaeSystemServices,
                                AppStrings.paintServices,
                                AppStrings.plumingServices,
                                AppStrings.phoneProgrammer,
                                AppStrings.tv,
                                AppStrings.designer,
                                AppStrings.porcalineWorker,
                                AppStrings.programmer
                              ]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedWork = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: defultButton(
                          text: "تعديل",
                          click: () {
                            if (fromstate.currentState!.validate()) {
                              AppFunctions.lodingDailog();
                              workerData.doc(id).update({
                                FirebaseConst.userName: controllerName.text,
                                FirebaseConst.userDis: controllerDis.text,
                                FirebaseConst.userPhone: controllerPhone.text,
                                FirebaseConst.userWorkType:
                                    types == UserTypes.WORKER
                                        ? selectedWork
                                        : ""
                              }).then((value) {
                                sharedPreferences.setString(
                                    AppConst.userName, controllerName.text);
                                Get.back();
                                Get.back();
                              });
                            }
                          },
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

EditeTextFormFiteld(
    {required BuildContext context,
    required String labeltext,
    required String hinttext,
    required IconData iconData,
    required TextEditingController controller,
    required String? Function(String?) valid,
    int lines = 1}) {
  return SizedBox(
    height: screenHeight(context) * 0.12,
    child: TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      validator: valid,
      maxLines: lines,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        enabledBorder: myOutlinrBorder(),
        focusedBorder: myOutlinrBorder(),
        errorBorder: myOutlinrBorder(),
        border: myOutlinrBorder(),
        disabledBorder: myOutlinrBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(iconData),
      ),
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:services/controllers/worker_Images_controller.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/view/screens/designs/worker_loading.dart';

// ignore: must_be_immutable
class WorkerImages extends StatefulWidget {
  String id;
  bool isAdmin;
  WorkerImages({super.key, required this.id, required this.isAdmin});

  @override
  State<WorkerImages> createState() =>
      _WorkerImagesState(id: id, isAdmin: isAdmin);
}

class _WorkerImagesState extends State<WorkerImages> {
  WorkerImagesController _imagesController = Get.put(WorkerImagesController());
  String id;
  bool isAdmin;
  _WorkerImagesState({required this.id, required this.isAdmin});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference _workerImages = FirebaseFirestore.instance
        .collection(FirebaseConst.users)
        .doc(id)
        .collection(FirebaseConst.workerImages);

    int imageslingth = 0;
    return Scaffold(
      floatingActionButton: StreamBuilder(
          stream: _workerImages.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return isAdmin == false
                  ? snapshot.data!.docs.length == 4
                      ? Container()
                      : FloatingActionButton(
                          onPressed: () {
                            _imagesController.uploadImage();
                            setState(() {});
                          },
                          child: Icon(Icons.add_a_photo_outlined),
                        )
                  : Container();
            }
            return Container();
          }),
      body: SafeArea(
        child: FutureBuilder(
            future: _workerImages.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                imageslingth = snapshot.data!.docs.length;
                return GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => imagesDesign(
                        id: id,
                        imgId: snapshot.data!.docs[index]
                            .get(FirebaseConst.imageId),
                        img: snapshot.data!.docs[index]
                            .get(FirebaseConst.imageUrl)));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return WorkerLoading();
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  imagesDesign(
      {required String id,
      required String img,
      required String imgId,
      }) {
    CollectionReference _workerImages = FirebaseFirestore.instance
        .collection(FirebaseConst.users)
        .doc(id)
        .collection(FirebaseConst.workerImages);
    return Stack(
      children: [
        Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ImageNetwork(
              height: 200,
              width: 200,
              image: img,
            )),
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
              onPressed: () async {
                Get.defaultDialog(
                    title: "مسح الصورة",
                    titleStyle: AppStyles.textBoldStyleColor(
                        color: Colors.black, size: 20),
                    content: Text(
                      "هل تريد مسح الصورة ؟",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleColor(
                          color: Colors.black, size: 17),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "لا",
                            style: AppStyles.textStyleColor(
                                color: Colors.blue, size: 12),
                          )),
                      TextButton(
                          onPressed: () async {
                            Get.back();
                            AppFunctions.lodingDailog();
                            await FirebaseStorage.instance
                                .refFromURL(img)
                                .delete()
                                .then((value) {
                              _workerImages.doc(imgId).delete();
                            }).then((value) {
                              _workerImages.doc(imgId).delete().then((value) {
                                Get.back();
                                setState(() {});
                              });
                            });
                          },
                          child: Text(
                            "نعم",
                            style: AppStyles.textStyleColor(
                                color: Colors.red, size: 12),
                          ))
                    ]);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.blue,
              )),
        )
      ],
    );
  }
}

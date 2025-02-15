import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/view/screens/designs/worker_loading.dart';

// ignore: must_be_immutable
class WorkerGallary extends StatelessWidget {
  String id;
  WorkerGallary({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    CollectionReference _workerImages = FirebaseFirestore.instance
        .collection(FirebaseConst.users)
        .doc(id)
        .collection(FirebaseConst.workerImages);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _workerImages.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => imagesDesignGellary(
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
}

imagesDesignGellary({required String img}) {
  return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ImageNetwork(
        height: 200,
        width: 200,
        image: img,
        
      ));
}

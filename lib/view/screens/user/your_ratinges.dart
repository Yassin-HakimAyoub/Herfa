import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/worker/worker_ratinngs.dart';

// ignore: must_be_immutable
class YouRatinges extends StatelessWidget {
  String workerId;
  YouRatinges({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> getMyRatings =
        FirebaseFirestore.instance.collection(FirebaseConst.rating);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تقيماتك',
          style: AppStyles.textStyleColor(color: Colors.black, size: 20),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: getMyRatings
                .where(FirebaseConst.ratingWorkerId, isEqualTo: workerId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("خطاء"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Loading(),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return workerCommintsDesign(context,
                          senderId: snapshot.data!.docs[index]
                              .get(FirebaseConst.ratingText),
                          commints: snapshot.data!.docs[index]
                              .get(FirebaseConst.ratingText),
                          ratingStars: snapshot.data!.docs[index]
                              .get(FirebaseConst.ratingStars),
                          senderName: snapshot.data!.docs[index]
                              .get(FirebaseConst.ratingSenderName));
                    });
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  "لا توجد تقيمات",
                  style: Theme.of(context).textTheme.displaySmall,
                ));
              }
              return Center(child: Container());
            }),
      ),
    );
  }
}

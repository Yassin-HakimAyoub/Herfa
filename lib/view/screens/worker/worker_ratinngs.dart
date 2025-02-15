import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/widgets/rating.dart';

// ignore: must_be_immutable
class WorkerRatings extends StatelessWidget {
  String workerId;
  WorkerRatings({super.key, required this.workerId});

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> getMyRatings =
        FirebaseFirestore.instance.collection(FirebaseConst.rating);

    return StreamBuilder<QuerySnapshot>(
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
                      ratingStars:
                          snapshot.data!.docs[index].get(FirebaseConst.ratingStars),
                      senderName: snapshot.data!.docs[index]
                          .get(FirebaseConst.ratingSenderName));
                });
          }if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text(
            "لا توجد تقيمات",
            style: Theme.of(context).textTheme.displaySmall,
          ));
          }
          return Center(
              child: Container());
        });
  }
}

workerCommintsDesign(BuildContext context,
    {required String commints,
    required int ratingStars,
    required String senderId,
    required String senderName}) {
  return SizedBox(
    width: screenWidth(context) - 10,
    child: Card(
        elevation: 0.5,
        child: ListTile(
          minLeadingWidth: 10,
          leading: CircleAvatar(radius: 18 , backgroundImage: NetworkImage(AppConst.defultImageUrl),),
          trailing: ratingStars == 0
              ? const Text(
                  AppStrings.ratingTypeveryBad,
                  style: TextStyle(
                      fontSize: 10, fontFamily: 'Cairo', color: Colors.red),
                )
              : ratingStars == 1
                  ? const Text(
                      AppStrings.ratingTypeAgree,
                      style: TextStyle(
                          fontFamily: 'Cairo', fontSize: 10, color: Colors.cyan),
                    )
                  : ratingStars == 2
                      ? const Text(
                          AppStrings.ratingTypeGood,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              color: Colors.orange),
                        )
                      : ratingStars == 3
                          ? const Text(
                              AppStrings.ratingTypeveryGood,
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  color: Colors.yellow),
                            )
                          : ratingStars == 4
                              ? const Text(
                                  AppStrings.ratingTypeveryExelent,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      color: Colors.blue),
                                )
                              : const Text(
                                  AppStrings.ratingTypeAwesome,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      color: Colors.green),
                                ),
          title: Text(
            senderName,
            style: const TextStyle(
                fontSize: 12, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: [
              CommintRating(ratingNum: ratingStars.toInt()),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenWidth(context) - 20,
                child: Text(
                  commints,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'Cairo', color: Colors.black54),
                ),
              )
            ],
          ),
        )),
  );
}

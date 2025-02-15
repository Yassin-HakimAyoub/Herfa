import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/designs/worker_booking_design.dart';

// ignore: must_be_immutable
class WorkerBooking extends StatelessWidget {
  var workerId = FirebaseAuth.instance.currentUser!.uid;
  Query<Map<String, dynamic>> getBooked =
      FirebaseFirestore.instance.collection(FirebaseConst.booking);

  WorkerBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: const Text(
          "الطلبات",
          style: TextStyle(
              fontSize: 20, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: getBooked
                  .where(FirebaseConst.bookingWorkerId,
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("خطاء"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Loading(),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return WorkerBookingDesign(
                          diBetween:snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingdistanceBetween) ,
                            services: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingService),
                            id: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingId),
                            name: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingWorkerName),
                            senderId: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingSenderId),
                            type: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingType),
                            location: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingLocation),
                            problemText: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingText),
                            time: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingTime));
                      });
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

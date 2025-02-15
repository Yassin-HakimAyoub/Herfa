import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/view/screens/designs/loading.dart';
import 'package:services/view/screens/designs/user_booking_design.dart';


// ignore: must_be_immutable
class UserBooking extends StatelessWidget {
  

  UserBooking({super.key});

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
              stream: FirebaseConst.bookingColumn
                  .where(FirebaseConst.bookingSenderId,
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
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
                        return UserBoolingDesign(
                            name: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingWorkerName),
                            type: snapshot.data!.docs[index]
                                .get(FirebaseConst.bookingType));
                      });
                }
                return Center(
                    child: Text(
                  "لا توجد طلبات",
                  style: Theme.of(context).textTheme.displaySmall,
                ));
              })),
    );
  }
}

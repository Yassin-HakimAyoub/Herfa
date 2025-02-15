import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:badges/badges.dart' as b;

// ignore: must_be_immutable
class MyBadge extends StatelessWidget {
  
  Color color;
  MyBadge({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> bookingReads =
        FirebaseFirestore.instance.collection(FirebaseConst.booking);
    return StreamBuilder<QuerySnapshot>(
        stream: bookingReads
            .where(FirebaseConst.bookingWorkerId,
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where(FirebaseConst.bookingRead, isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return b.Badge(
                badgeAnimation: const b.BadgeAnimation.fade(),
                showBadge: snapshot.data!.docs.isNotEmpty ? true : false,
                badgeContent: Text("${snapshot.data!.docs.length}"),
                child: Icon(
                  Icons.shopping_cart,
                  color: color,
                ));
          }
          return Container();
        });
  }
}

// ignore: must_be_immutable
class UserMoneyBadge extends StatelessWidget {
  Color color;
  UserMoneyBadge({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> bookingReads =
        FirebaseFirestore.instance.collection(FirebaseConst.moneyCollection);
    return StreamBuilder<QuerySnapshot>(
        stream: bookingReads
            .where(FirebaseConst.moneyUserId,
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where(FirebaseConst.moneyRead, isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return b.Badge(
                badgeAnimation: const b.BadgeAnimation.fade(),
                showBadge: snapshot.data!.docs.isNotEmpty ? true : false,
                badgeContent: Text("${snapshot.data!.docs.length}"),
                child: Icon(
                  CupertinoIcons.doc_plaintext,
                  color: color,
                ));
          }
          return Container();
        });
  }
}

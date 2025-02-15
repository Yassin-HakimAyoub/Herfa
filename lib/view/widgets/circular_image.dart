import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class CircleImage extends StatefulWidget {
  double radius;
  String id;
  double height, width;
  CircleImage(
      {super.key,
      required this.height,
      required this.width,
      required this.id,
      required this.radius});

  @override
  State<CircleImage> createState() =>
      _CircularImageState(id: id, radius: radius, height: height, width: width);
}

class _CircularImageState extends State<CircleImage> {
  double radius;
  String id;
  double height, width;
  _CircularImageState(
      {required this.height,
      required this.width,
      required this.id,
      required this.radius});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseConst.userColumn
            .where(FirebaseConst.userId, isEqualTo: id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: ImageNetwork(
                          height: height,
                          width: width,
                          onError: CircleAvatar(
                            radius: radius,
                            backgroundImage:
                                NetworkImage(AppConst.defultImageUrl),
                          ),
                          onLoading: Shimmer.fromColors(
                            child: CircleAvatar(radius: radius),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                          ),
                          image: snapshot.data!.docs[index]
                              .get(FirebaseConst.userProfileImage),
                        ),
                      ),
                      snapshot.data!.docs[index]
                                      .get(FirebaseConst.userRating) >=
                                  100 ||
                              snapshot.data!.docs[index]
                                      .get(FirebaseConst.userAdmin) ==
                                  true
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.verified,
                                color: Colors.blue,
                              ),
                            )
                          : Container()
                    ],
                  );
                });
          } else {
            return Container();
          }
        });
  }
}

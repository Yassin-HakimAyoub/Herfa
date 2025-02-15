import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/view/screens/designs/services_design.dart';
import 'package:services/view/screens/designs/worker_loading.dart';

import 'package:services/view/widgets/mytextforms.dart';

// ignore: must_be_immutable
class SearchServices extends StatefulWidget {
  String workType;
  SearchServices({super.key, required this.workType});

  @override
  State<SearchServices> createState() => _SearchServicesState(work: workType);
}

class _SearchServicesState extends State<SearchServices> {
  String work;
  _SearchServicesState({required this.work});
  String query = "";
  Query<Map<String, dynamic>> usersServices =
      FirebaseFirestore.instance.collection(FirebaseConst.users);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "البحث",
                enabledBorder: myOutlinrBorder(),
                focusedBorder: myOutlinrBorder(),
                errorBorder: myOutlinrBorder(),
                border: myOutlinrBorder(),
                disabledBorder: myOutlinrBorder(),
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: usersServices
              .where(FirebaseConst.userWorkType, isEqualTo: work)
              .where(FirebaseConst.userIsWorker, isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppStrings.error,
                  style: AppStyles.textStyle(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: WorkerLoading());
            } else if (snapshot.hasData) {
              Iterable<QueryDocumentSnapshot> subList = snapshot.data!.docs
                  .where((element) =>
                      element.get(FirebaseConst.userName).startsWith(query));
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: subList.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return ServicesDesign(
                      workerImage:subList.elementAt(index).get(FirebaseConst.userProfileImage) ,
                      lat:subList.elementAt(index).get(FirebaseConst.userLat) ,
                      long: subList.elementAt(index).get(FirebaseConst.userLong),
                      isOnline: subList.elementAt(index).get(FirebaseConst.userIsOnline),
                      disc: subList.elementAt(index).get(FirebaseConst.userDis),
                      id: subList.elementAt(index).get(FirebaseConst.userId),
                      job: subList
                          .elementAt(index)
                          .get(FirebaseConst.userWorkType),
                      location:
                          subList.elementAt(index).get(FirebaseConst.userState),
                      name:
                          subList.elementAt(index).get(FirebaseConst.userName),
                      token:
                          subList.elementAt(index).get(FirebaseConst.userToken),
                      rating: subList
                          .elementAt(index)
                          .get(FirebaseConst.userRating),
                    );
                  });
            } else if (!snapshot.hasData) {
              return Center(
                  child: Text(
                AppStrings.noWorker,
                style: AppStyles.textStyle(),
              ));
            } else {
              return WorkerLoading();
            }
          }),
    );
  }
}

/*
*/

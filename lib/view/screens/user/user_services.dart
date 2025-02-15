// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/view/screens/designs/service_search.dart';
import 'package:services/view/screens/designs/services_design.dart';
import 'package:services/view/screens/designs/worker_loading.dart';

// ignore: must_be_immutable
class UserServiceScreen extends StatelessWidget {
  String serviceName;
  String serivcePath;
  UserServiceScreen(
      {super.key, required this.serivcePath, required this.serviceName});
  Query<Map<String, dynamic>> usersServices =
      FirebaseFirestore.instance.collection(FirebaseConst.users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            serviceName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchServices(
                                workType: serviceName,
                              )));
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: FutureBuilder(
            future: usersServices
                .where(FirebaseConst.userWorkType, isEqualTo: serviceName)
                .where(FirebaseConst.userIsWorker, isEqualTo: true)
                .get(),
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
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 3, crossAxisCount: 2),
                    itemCount: snapshot.data!.docs.length,
                    padding: EdgeInsets.all(2),
                    itemBuilder: (context, index) {
                      return ServicesDesign(
                          workerImage: snapshot.data!.docs[index]
                              .get(FirebaseConst.userProfileImage),
                          lat: snapshot.data!.docs[index]
                              .get(FirebaseConst.userLat),
                          long: snapshot.data!.docs[index]
                              .get(FirebaseConst.userLong),
                          isOnline: snapshot.data!.docs[index]
                              .get(FirebaseConst.userIsOnline),
                          name: snapshot.data!.docs[index]
                              .get(FirebaseConst.userName),
                          job: snapshot.data!.docs[index]
                              .get(FirebaseConst.userWorkType),
                          id: snapshot.data!.docs[index]
                              .get(FirebaseConst.userId),
                          location: snapshot.data!.docs[index]
                              .get(FirebaseConst.userState),
                          token: snapshot.data!.docs[index]
                              .get(FirebaseConst.userToken),
                          rating: snapshot.data!.docs[index]
                              .get(FirebaseConst.userRating),
                          disc: snapshot.data!.docs[index]
                              .get(FirebaseConst.userPhone));
                    });
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  AppStrings.noWorker,
                  style: AppStyles.textBoldStyleColor(
                      color: Colors.black, size: 16),
                ));
              } else {
                return WorkerLoading();
              }
            }));
  }
}

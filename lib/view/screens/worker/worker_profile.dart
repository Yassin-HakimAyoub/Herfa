import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/view/screens/home/booking.dart';
import 'package:services/view/screens/worker/worker_all_data.dart';
import 'package:services/view/screens/worker/worker_gallary.dart';
import 'package:services/view/screens/worker/worker_ratinngs.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/mytextforms.dart';
import 'package:services/view/widgets/rating.dart';

// ignore: must_be_immutable
class WorkerProfiles extends StatefulWidget {
  String worName;
  String worJob;
  String woId;
  String woToken;
  String woLocation;
  double lat;
  double long;
  int rat;

  WorkerProfiles(
      {super.key,
      required this.worName,
      required this.lat,
      required this.long,
      required this.rat,
      required this.woId,
      required this.worJob,
      required this.woToken,
      required this.woLocation});

  @override
  // ignore: no_logic_in_create_state
  State<WorkerProfiles> createState() => _WorkerProfilesState(
      workerName: worName,
      workerId: woId,
      workerJob: worJob,
      lat: lat,
      long: long,
      rating: rat,
      workerToken: woToken,
      workerLocation: woLocation);
}

class _WorkerProfilesState extends State<WorkerProfiles>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  bool isFavorit = false;
  List screenNamesList = ["اعمال سابقة", "التقيمات", "عن المقدم"];
  String workerName;
  String workerJob;
  String workerLocation;
  String workerId;
  String workerToken;
  int curIndex = 0;
  double long;
  double lat;
  String image = "";
  int rating;
  _WorkerProfilesState(
      {required this.workerName,
      required this.workerId,
      required this.lat,
      required this.rating,
      required this.long,
      required this.workerJob,
      required this.workerToken,
      required this.workerLocation});

  getData() async {
    var data = await FirebaseFunctions.getOneColumn(
        id: FirebaseAuth.instance.currentUser!.uid,
        column: FirebaseConst.users);
    image = data[FirebaseConst.userProfileImage];
  }

  @override
  void initState() {
    getData();
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingScreen(
                            lat: lat,
                            long: long,
                            name: workerName,
                            location: workerLocation,
                            workerId: workerId,
                            ourServices: workerJob)));
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ))
            ],
            backgroundColor: AppColor.appMainColor,
            flexibleSpace: firstWidget(context,
                id: workerId,
                profileImage: image,
                rat: rating,
                name: workerName),
            leading: Container(),
            toolbarHeight: screenHeight(context) * 0.40,
            bottom: TabBar(
                indicatorColor: Colors.white,
                controller: controller,
                tabs: const [
                  Tab(
                    child: Text(
                      "عن المقدم",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "القيمات",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "اعمال السابقة",
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  )
                ]),
            title: const Text(""),
            centerTitle: true),
        body: TabBarView(controller: controller, children: [
          WorkerAllData(workerId: workerId),
          WorkerRatings(workerId: workerId),
          WorkerGallary(
            id: workerId,
          )
        ]));
  }
}

firstWidget(BuildContext context,
    {required String name,
    required String id,
    required String profileImage,
    required int rat}) {
  return Container(
    height: screenHeight(context) * 0.50,
    width: screenWidth(context),
    decoration: const BoxDecoration(color: AppColor.appMainColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: screenHeight(context) * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                height: 140,
                child: CircleImage(
                  id: id,
                  radius: 100,
                  height: 100,
                  width: 100,
                ))
          ],
        ),
        Text(
          name,
          style: const TextStyle(
              fontFamily: "Cairo",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RatingWidget(
            context,
            ratingNum: rat,
          ),
        )
      ],
    ),
  );
}

myTextEditproblem(BuildContext context,
    {required String hint,
    required TextEditingController controller,
    required String problem,
    required int maxL}) {
  return TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      maxLength: maxL,
      validator: (val) => validInput(val!, 1, maxL, "text"),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: hint,
        labelText: problem,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: myOutlinrBorder(),
        focusedBorder: myOutlinrBorder(),
        errorBorder: myOutlinrBorder(),
        border: myOutlinrBorder(),
        disabledBorder: myOutlinrBorder(),
      ));
}

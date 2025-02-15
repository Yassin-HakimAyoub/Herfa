import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/data_list.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/view/widgets/badge.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> with WidgetsBindingObserver {
  int _selectPage = 0;

  @override
  void initState() {
    super.initState();
    AppFunctions.getPosition();
    AppFunctions.updateLocation(id: FirebaseAuth.instance.currentUser!.uid);
    chanageState(FirebaseConst.onLine);
    WidgetsBinding.instance.addObserver(this);
  }

  void chanageState(String state) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(FirebaseConst.users);
    reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({FirebaseConst.userIsOnline: state});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      chanageState(FirebaseConst.onLine);
    } else if (state == AppLifecycleState.paused) {
      chanageState(FirebaseConst.offLine);
    }else if(state == AppLifecycleState.hidden){

    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectPage,
          onTap: (index) {
            setState(() {
              _selectPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  color: _selectPage == 0 ? AppColor.appMainColor : Colors.black54,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: MyBadge(
                    color: _selectPage == 1 ? AppColor.appMainColor: Colors.black54),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: _selectPage == 2 ? AppColor.appMainColor : Colors.black54,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.image_outlined,
                  color: _selectPage == 3 ? AppColor.appMainColor : Colors.black54,
                ),
                label: ""),
          ]),
      body: ListData.workerPagesList.elementAt(_selectPage),
    );
  }
}

cardDesign(BuildContext context, {required String titel}) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(
          Icons.notifications,
          size: 30,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          titel,
          style: Theme.of(context).textTheme.displaySmall,
        )
      ],
    ),
  );
}

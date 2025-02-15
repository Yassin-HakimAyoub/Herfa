import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/data_list.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/main.dart';
import 'package:services/view/widgets/badge.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return homeState();
  }
}

class homeState extends State<UserHome> {
  int selectPage = 0;


  @override
  void initState() {
    sharedPreferences.setString(AppConst.isOnBoarding, "3");
    AppFunctions.getPosition();
    AppFunctions.updateLocation(id: FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectPage,
        onTap: (index) {
          setState(() {
            selectPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: selectPage == 0 ? AppColor.appMainColor : Colors.black54,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: selectPage == 1 ? AppColor.appMainColor : Colors.black54,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: UserMoneyBadge(
                color: selectPage == 2 ? AppColor.appMainColor : Colors.black54,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,
                  color:
                      selectPage == 3 ? AppColor.appMainColor : Colors.black54),
              label: "")
        ],
      ),
      body: ListData.pages.elementAt(selectPage),
    );
  }
}

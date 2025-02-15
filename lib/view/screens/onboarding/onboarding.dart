import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/data_list.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/services/services.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController pageController;
  myServices myser = Get.find();
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appMainColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: pageController,
                itemCount: ListData.onBoardingList.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ListData.onBoardingList[i].title,
                            textAlign: TextAlign.center,
                            style: AppStyles.textBoldStyleColor(
                                color: Colors.white, size: 15),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        ListData.onBoardingList[i].image))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(
                                  ListData.onBoardingList[i].description,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleColor(
                                      color: Colors.white, size: 13)))
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(ListData.onBoardingList.length,
                (index) => bulidDot(context, index)),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                    currentIndex == ListData.onBoardingList.length - 1
                        ? AppStrings.enter
                        : AppStrings.next,
                    style: AppStyles.textBoldStyleColor(
                        color: Colors.black, size: 15)),
                onPressed: () {
                  if (currentIndex == ListData.onBoardingList.length - 1) {
                    myser.sharedPreferences
                        .setString(AppConst.isOnBoarding, "1");
                    Get.offAllNamed(AppRoutes.chooseLanguage);
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => signupScreen()));
                  }
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                }),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  AnimatedContainer bulidDot(BuildContext context, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
    );
  }
}

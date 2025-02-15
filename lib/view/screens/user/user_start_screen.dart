import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/data_list.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/designs/drawar.dart';
import 'package:services/view/screens/user/user_services.dart';

class UserStartScreen extends StatelessWidget {
  //UserHomeController userHomeController = Get.put(UserHomeController());
  UserStartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawar(context,
          types: UserTypes.USER,
          name: "SECO",
          email: "yassinhakim2001@gmail.com"),
      appBar: AppBar(
        toolbarHeight: 40,
        title: Row(
          children: [
            Text(
              "مرحبا , ",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              "${sharedPreferences.getString(AppConst.userName).toString().split(" ")[0]}",
              style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
              padding: const EdgeInsets.only(bottom: 4),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  title: Text(
                    AppFunctions.myLocation, //userHomeController.yourLocation,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: screenHeight(context) * 0.02,
            ),
            Container(
              width: screenWidth(context) - 20,
              height: screenHeight(context) * 0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.appMainColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "حِرفه",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          AppStrings.mainText_1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          AppStrings.mainText_2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: screenHeight(context) * 0.60,
                      width: screenWidth(context) * 0.30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.startImage1),
                              fit: BoxFit.contain)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "الخدمات",
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.allService);
                    },
                    child: const Text(
                      "عرض الكل",
                      style: TextStyle(
                          color: AppColor.appMainColor,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox (
             height: screenHeight(context) * 0.36,
              width: screenWidth(context) - 20,
              child: Center(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: ListData.serviceData.length,
                    itemBuilder: (context, index) {
                      return serviceCard(
                        context,
                        text: ListData.serviceData[index].getText,
                        image: ListData.serviceData[index].getImage,
                        path: ListData.serviceData[index].path,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget serviceCard(BuildContext context,
    {required String text, required String image, required String path}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              UserServiceScreen(serivcePath: path, serviceName: text)));
    },
    child: Card(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 1),
          width: screenWidth(context) * 0.10,
          height: screenHeight(context) * 0.10,
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image))),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 10, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        )
      ]),
    ),
  );
}

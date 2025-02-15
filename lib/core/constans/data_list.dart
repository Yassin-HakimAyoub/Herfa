import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services/core/classes/manageData.dart';
import 'package:services/core/classes/onbordingdata.dart';
import 'package:services/core/classes/service_data.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/enums.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/view/screens/home/view_money_data.dart';
import 'package:services/view/screens/notifications/notifications_screen.dart';
import 'package:services/view/screens/user/user_boolking.dart';
import 'package:services/view/screens/user/user_start_screen.dart';
import 'package:services/view/screens/worker/worker_booking.dart';
import 'package:services/view/screens/worker/worker_images.dart';
import 'package:services/view/screens/worker/worker_start_screen.dart';

class ListData {
  static List<onBoardingData> onBoardingList = [
    onBoardingData(
        description:
            "سوق نفسك و اعمالك عبر التسجيل في التطبيق عبر حساب مقدم خدمة و عرض اعمالك و إستلام الطلبات من المستخدمين",
        image: AppImages.onBoardingImage1,
        title: 'سوق نفسك'),
    onBoardingData(
        description:
            "ابحث عن افضل مقدمي الخدمة و انجز عملك و وفر لنفسك الوقت و تعب البحث",
        image: AppImages.onBoardingImage2,
        title: 'توفير الوقت و الجهد'),
    onBoardingData(
        description:
            "انجز عملك بكل امانة و قم بارسال الفاتورة الى العميل لتحصل على اعلى تقييم و لترتقي الى رتبة افضل مقدمي الخدمة و تحصل على علامة التوثيق",
        image: AppImages.onBoardingImage3,
        title: 'احصل على اعلى تقييم'),
  ];

  static List workerPagesList = [
    const workerStartScreen(),
    WorkerBooking(),
    const notificationScreen(),
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text(
          "المعرض",
          style: AppStyles.textBoldStyle(),
        ),
      ),
      body: WorkerImages(
        id: FirebaseAuth.instance.currentUser!.uid,
        isAdmin: false,
      ),
    )
  ];

  static List appBarText = ["", "الاشعارات", "التحميلات", "الملف الشخصي"];

  static List<Widget> pages = [
    UserStartScreen(),
    const notificationScreen(),
    ViewMoneyData(),
    UserBooking()
  ];

  static final List<manageData> manageList = [
    manageData(
        iconData: Icons.notifications,
        manageType: ManageType.NOTIFICATION,
        text: "Notifications",
        path: FirebaseConst.notification),
    manageData(
        iconData: Icons.person,
        manageType: ManageType.USERS,
        text: "Users",
        path: FirebaseConst.users),
    manageData(
        iconData: Icons.settings,
        manageType: ManageType.SERVICES,
        text: "Services",
        path: FirebaseConst.booking),
    manageData(
        iconData: Icons.monetization_on_outlined,
        manageType: ManageType.MONEYDATA,
        text: "MoneyData",
        path: FirebaseConst.moneyCollection),
  ];
  static final List<ServiceData> serviceData = [
    ServiceData(
        image: AppImages.cctvImage,
        text: AppStrings.installCctvServices,
        path: ""),
    ServiceData(
        image: AppImages.cleanningImage,
        text: AppStrings.cleaningServices,
        path: ""),
    ServiceData(
        image: AppImages.startImage1,
        text: AppStrings.paintServices,
        path: ""),
    ServiceData(
        image: AppImages.hairstylingImage,
        text: AppStrings.hairStyleServices,
        path: ""),
    ServiceData(
        image: AppImages.onBoardingImage3,
        text: AppStrings.fixedElectricServices,
        path: ""),
    ServiceData(
        image: AppImages.onBoardingImage2,
        text: AppStrings.electricServices,
        path: ""),
  ];

  static List<ServiceData> allser = [
    ServiceData(
        image: AppImages.cctvImage,
        text: AppStrings.installCctvServices,
        path: ""),
    ServiceData(
        image: AppImages.cleanningImage,
        text: AppStrings.cleaningServices,
        path: ""),
    ServiceData(
        image: AppImages.startImage1,
        text: AppStrings.paintServices,
        path: ""),
    ServiceData(
        image: AppImages.hairstylingImage,
        text: AppStrings.hairStyleServices,
        path: ""),
    ServiceData(
        image: AppImages.onBoardingImage3,
        text: AppStrings.fixedElectricServices,
        path: ""),
    ServiceData(
        image: AppImages.onBoardingImage2,
        text: AppStrings.electricServices,
        path: ""),
    ServiceData(
        image: AppImages.solarEnergy,
        text: AppStrings.installSolaeSystemServices,
        path: ""),
    ServiceData(
        image: AppImages.onBoardingImage5,
        text: AppStrings.plumingServices,
        path: ""),
    ServiceData(
        image: AppImages.maintenanceImage,
        text: AppStrings.installAirConditionServices,
        path: ""),
    ServiceData(
        image: AppImages.plasteringImage,
        text: AppStrings.buildingServices,
        path: ""),
    ServiceData(
        image: AppImages.programmer, text: AppStrings.programmer, path: ""),
    ServiceData(image: AppImages.designer, text: AppStrings.designer, path: ""),
    ServiceData(
        image: AppImages.phoneProgrammer,
        text: AppStrings.phoneProgrammer,
        path: ""),
    ServiceData(
        image: AppImages.porcalinWorkerImage,
        text: AppStrings.porcalineWorker,
        path: ""),
    ServiceData(
        image: AppImages.tvImag, text: AppStrings.tv, path: ""),
  ];
}

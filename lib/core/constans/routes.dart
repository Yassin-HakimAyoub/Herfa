import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/view/screens/auth/forgetpassword_screen.dart';
import 'package:services/view/screens/auth/signin_screen.dart';
import 'package:services/view/screens/auth/splash_screen.dart';
import 'package:services/view/screens/auth/verified_screen.dart';
import 'package:services/view/screens/home/all_services_screen.dart';
import 'package:services/view/screens/home/view_money_data.dart';
import 'package:services/view/screens/manage/control_panal.dart';
import 'package:services/view/screens/manage/manage_notification.dart';
import 'package:services/view/screens/notifications/pay_screen.dart';
import 'package:services/view/screens/onboarding/choose_account.dart';
import 'package:services/view/screens/onboarding/onboarding.dart';
import 'package:services/view/screens/user/user_home.dart';
import 'package:services/view/screens/worker/worker_home.dart';
import 'package:services/view/widgets/block.dart';
import 'package:services/view/widgets/booking_ok.dart';
import 'package:services/view/widgets/check.dart';
import 'package:services/view/widgets/success_forgetpassword.dart';

List<GetPage<dynamic>> routes = [
  //splashScreen
  GetPage(name: "/", page: () => const splashScreen()),
  GetPage(
    name: AppRoutes.chooseLanguage,
    page: () => const ChooseAccountScreen(),
  ),
  //manageUser
  //controlPanal
  GetPage(
      name: AppRoutes.forgetpassword, page: () => const ForgetPasswordScreen()),
  GetPage(
      name: AppRoutes.manageNotifications, page: () => const ManageNotifications()),
  GetPage(name: AppRoutes.viewmoney, page: () => ViewMoneyData()),
  GetPage(name: AppRoutes.checkScreen, page: () => const Check()),
  GetPage(name: AppRoutes.payscreen, page: () => const PayScreen()),

  GetPage(name: AppRoutes.successrewirtePass, page: () => const SuccessRewritePassword()),
 
  GetPage(name: AppRoutes.block, page: () => const Block()),

  GetPage(name: AppRoutes.controlPanal, page: () => ControlPanal()),
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.bookingsccess, page: () =>  BookingOk()),
  GetPage(name: AppRoutes.onboarding, page: () => const OnBoardingScreen()),
  GetPage(name: AppRoutes.home, page: () => const UserHome()),
  GetPage(name: AppRoutes.workerhome, page: () => const WorkerHome()),
  GetPage(name: AppRoutes.verifyCode, page: () => VerifiedScreen()),
  GetPage(name: AppRoutes.allService, page: () => const AllServices()),
];

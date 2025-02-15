import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/routes.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

late SharedPreferences sharedPreferences;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();
  AppFunctions.changeLocalTime();
  await initialServices();
  //var yourId = FirebaseAuth.instance.currentUser!.uid;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return appBody();
  }
}

class appBody extends StatelessWidget {
  const appBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale("ar"),
      debugShowCheckedModeBanner: false,
      getPages: routes,
      //routes: routes,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          buttonTheme: ButtonThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColor.appMainColor)),
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColor.appBlack),
              displaySmall: TextStyle(
                  fontFamily: 'Cairo', fontSize: 16, color: AppColor.appBlack),
              bodySmall: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: AppColor.appBlack))),
      //home: /* splashScreen() Home()*/
    );
  }
}

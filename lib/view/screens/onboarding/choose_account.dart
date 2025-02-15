import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/controllers/local_controller.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/view/screens/auth/singup_screen.dart';

class ChooseAccountScreen extends GetView<LocalController> {
  const ChooseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appMainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(AppStrings.chooseAccount,
                  style: AppStyles.textBoldStyleColor(
                      color: Colors.white, size: 18)),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignupScreen(iswo: false)));
                      },
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Text(
                        AppStrings.normalUser,
                        style: AppStyles.textBoldStyleColor(
                            color: Colors.black, size: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignupScreen(iswo: true)));
                      },
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Text(
                        AppStrings.workerAccount,
                        style: AppStyles.textBoldStyleColor(
                            color: Colors.black, size: 12),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

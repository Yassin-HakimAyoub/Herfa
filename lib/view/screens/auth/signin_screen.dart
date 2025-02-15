import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/controllers/login_controller.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_colors.dart';
import 'package:services/core/constans/app_routes.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/core/constans/image_const.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/view/widgets/defult_button.dart';
import 'package:services/view/widgets/mytextforms.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginConttrollerImp loginConttrollerImp = Get.put(LoginConttrollerImp());
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight(context) * 0.25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.logo2),
                        fit: BoxFit.contain)),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: loginConttrollerImp.fromstate,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customTextFiled(
                            editingController: _email,
                            hinttext: AppHints.emailHint,
                            iconData: Icons.email,
                            labeltext: AppHints.emailLable,
                            textInputType: TextInputType.emailAddress,
                            valid: (val) {
                              return validInput(val!, 10, 30, AppConst.email);
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GetBuilder<LoginConttrollerImp>(
                            builder: (controller) => customTextFiled(
                                isPassword: controller.isShowPassword,
                                chanagePass: controller.changeShowPassword(),
                                hinttext: AppHints.passwordHint,
                                valid: (val) {
                                  return validInput(
                                      val!, 5, 14, AppConst.password);
                                },
                                editingController: _password,
                                textInputType: TextInputType.text,
                                iconData: Icons.lock,
                                labeltext: AppHints.passwordLable)),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgetpassword);
                      },
                      child: Text(
                        "نسيت كلمة السر",
                        style: AppStyles.textStyleColor(
                            color: AppColor.appMainColor, size: 16),
                      )),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              defultButton(
                  text: AppStrings.login,
                  click: () async {
                    loginConttrollerImp.login(
                        context: context,
                        email: _email.text,
                        password: _password.text);
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.iDonotHaveAccount,
                    style: AppStyles.textStyle(),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.chooseLanguage);
                    },
                    child: const Text(
                      AppStrings.createAccount,
                      style: TextStyle(
                          color: AppColor.appMainColor,
                          fontFamily: AppConst.cairoFont),
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

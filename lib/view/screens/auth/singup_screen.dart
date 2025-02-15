import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/controllers/signup_controller.dart';
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
class SignupScreen extends StatelessWidget {
  bool iswo;
  SignupScreen({super.key, required this.iswo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.createAccount,
          style: AppStyles.textBoldStyleColor(color: Colors.black, size: 20),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: screenHeight(context) * 0.20,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.logo2),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "مرحبا بك في تطبيقنا انشاء حسابك و استمتع بي افضل الخدمات",
                textAlign: TextAlign.center,
                style: AppStyles.textBoldStyleColor(color: Colors.black, size: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              SignUpForm(isworker: iswo),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SignUpForm extends StatefulWidget {
  bool isworker;
  SignUpForm({super.key, required this.isworker});

  @override
  State<SignUpForm> createState() => _SignUpFormState(isWorker: isworker);
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpControllerImp signUpConttrollerImp = Get.put(SignUpControllerImp());
  double? siz = 10;
  bool isWorker;
  _SignUpFormState({required this.isWorker});
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController workDiscription = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    workDiscription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: signUpConttrollerImp.formstate,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              customTextFiled(
                  hinttext: AppHints.userNameHint,
                  valid: (val) {
                    return validInput(val!, 5, 18, AppConst.userName);
                  },
                  editingController: username,
                  textInputType: TextInputType.text,
                  iconData: Icons.person,
                  labeltext: AppHints.nameLable),
              SizedBox(
                height: siz,
              ),
              Visibility(
                visible: isWorker,
                child: Container(
                  height: 68,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54)),
                  child: GetBuilder<SignUpControllerImp>(
                      builder: (contr) => DropdownButtonFormField(
                          hint: const Text(AppHints.workHint),
                          validator: (value) =>
                              validInput(value!, 5, 20, AppConst.worker),
                          items: [
                            AppStrings.buildingServices,
                            AppStrings.cleaningServices,
                            AppStrings.electricServices,
                            AppStrings.fixedElectricServices,
                            AppStrings.hairStyleServices,
                            AppStrings.installAirConditionServices,
                            AppStrings.installCctvServices,
                            AppStrings.installSolaeSystemServices,
                            AppStrings.paintServices,
                            AppStrings.plumingServices,
                            AppStrings.phoneProgrammer,
                            AppStrings.tv,
                            AppStrings.designer,
                            AppStrings.porcalineWorker,
                            AppStrings.programmer
                          ]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            contr.updateWork(value!);
                          })),
                ),
              ),
              SizedBox(
                height: siz,
              ),
              customTextFiled(
                  hinttext: AppHints.phoneHint,
                  valid: (val) {
                    return validInput(val!, 5, 10, AppConst.phone);
                  },
                  editingController: phone,
                  textInputType: TextInputType.text,
                  iconData: Icons.phone,
                  labeltext: AppHints.phoneLable),
              SizedBox(
                height: siz,
              ),
              customTextFiled(
                  hinttext: AppHints.emailHint,
                  valid: (val) {
                    return validInput(val!, 5, 40, AppConst.email);
                  },
                  editingController: email,
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email,
                  labeltext: AppHints.emailLable),
              SizedBox(
                height: siz,
              ),
              customTextFiled(
                  hinttext: AppHints.passwordHint,
                  isPassword: true,
                  valid: (val) {
                    return validInput(val!, 5, 10, "password");
                  },
                  editingController: password,
                  textInputType: TextInputType.visiblePassword,
                  iconData: Icons.lock,
                  labeltext: AppHints.passwordLable),
              SizedBox(
                height: siz,
              ),
              Visibility(
                visible: isWorker,
                child: SizedBox(
                  height: screenHeight(context) * 0.20,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLength: 200,
                    maxLines: 7,
                    minLines: 5,
                    controller: workDiscription,
                    validator: (value) {
                      return validInput(value!, 20, 200, AppConst.longText);
                    },
                    decoration: InputDecoration(
                      labelText: AppHints.descriptionLable,
                      hintText: AppHints.descriptionHint,
                      enabledBorder: myOutlinrBorder(),
                      focusedBorder: myOutlinrBorder(),
                      errorBorder: myOutlinrBorder(),
                      border: myOutlinrBorder(),
                      disabledBorder: myOutlinrBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.login);
                },
                child: Text(
                  " لدي حساب ؟ تسجيل دخول ",
                  style: AppStyles.textStyleColor(
                      color: AppColor.appMainColor, size: 15),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              defultButton(
                  text: AppStrings.create,
                  click: () {
                    if (isWorker == true) {
                      signUpConttrollerImp.signUp(context,
                          username: username.text,
                          email: email.text,
                          pass: password.text,
                          phone: phone.text,
                          isworker: isWorker,
                          workerDis: workDiscription.text);
                    } else {
                      signUpConttrollerImp.signUp(context,
                          username: username.text,
                          email: email.text,
                          pass: password.text,
                          phone: phone.text,
                          isworker: false,
                          workerDis: "");
                    }
                  }),
            ],
          ),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/functions/firebase_functions.dart';
import 'package:services/core/functions/func.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/core/functions/validation.dart';
import 'package:services/main.dart';
import 'package:services/view/screens/worker/worker_profile.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/defult_button.dart';
import 'package:services/view/widgets/mytextforms.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  String name;
  String ourServices;
  String location;
  String workerId;
  double long;
  double lat;
  BookingScreen(
      {super.key,
      required this.lat,
      required this.long,
      required this.name,
      required this.location,
      required this.ourServices,
      required this.workerId});

  @override
  State<BookingScreen> createState() => _BookingScreenState(
      lat: lat,
      location: location,
      long: long,
      name: name,
      ourServices: ourServices,
      workerId: workerId);
}

class _BookingScreenState extends State<BookingScreen> {
  String name;
  String ourServices;
  String location;
  String workerId;
  double long;
  double lat;

  int between = 0;

  var yourId = FirebaseAuth.instance.currentUser!.uid;
  GlobalKey<FormState> fromstateKey = GlobalKey<FormState>();

  TextEditingController proController = TextEditingController();
  TextEditingController locController = TextEditingController();
  _BookingScreenState(
      {required this.name,
      required this.location,
      required this.ourServices,
      required this.long,
      required this.lat,
      required this.workerId});

  getPos() async {
    Position position = await Geolocator.getCurrentPosition();
    var dist = Geolocator.distanceBetween(
        lat, long, position.latitude, position.longitude);
    between = dist.toInt();
  }

  @override
  void initState() {
    getPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "طلب حجز",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleImage(
                      id: workerId,
                      radius: 80,
                      width: 80,
                      height: 80,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("الخدمة",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.black54)),
                    Text(
                      ourServices,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("يبعد عنك",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.black54)),
                    Text(" ${between.toInt()} متر",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  width: screenWidth(context) - 20,
                  child: Form(
                      child: myTextEditproblem(context,
                          maxL: 300,
                          hint: "شرح موجز عن الخدمة",
                          controller: proController,
                          problem: " المشكلة")),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth(context) - 20,
                  height: 100,
                  child: Form(
                    key: fromstateKey,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: locController,
                        maxLength: 30,
                        validator: (val) {
                          return validInput(val!, 3, 20, "");
                        },
                        decoration: InputDecoration(
                          hintText: "ادخل موقعك الحالي",
                          labelText: "الموقع",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: myOutlinrBorder(),
                          focusedBorder: myOutlinrBorder(),
                          errorBorder: myOutlinrBorder(),
                          border: myOutlinrBorder(),
                          disabledBorder: myOutlinrBorder(),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            defultButton(
                click: () {
                  if (fromstateKey.currentState!.validate()) {
                    try {
                      AppFunctions.lodingDailog();
                      FirebaseFunctions.addBooking(context,
                          senderId: yourId,
                          workerId: workerId,
                          services: ourServices,
                          workerName: name,
                          distanceBetween: between,
                          locations: locController.text,
                          senderName:
                              sharedPreferences.getString(AppConst.userName)!,
                          text: proController.text);
                    } catch (e) {
                      Get.defaultDialog(
                          title: "",
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.clear_outlined),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("$e")
                            ],
                          ));
                    }
                  }
                },
                text: "حجز")
          ],
        ));
  }
}

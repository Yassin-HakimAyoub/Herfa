import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';

import '../core/functions/firebase_functions.dart';

class AppInitController extends GetxController {
  var userData;
  
  @override
  void onInit() async {
        userData = await FirebaseFunctions.getOneColumn(
        id: FirebaseAuth.instance.currentUser!.uid ,
        column: FirebaseConst.users);
    
    super.onInit();
  }
}

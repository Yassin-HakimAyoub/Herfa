import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class UserHomeController extends GetxController {
  late bool services;
  late LocationPermission locationPermission;
  late Position yourPostion;
  String yourLocation = "";
  Future getPostion() async {
    services = await Geolocator.isLocationServiceEnabled();
    if (services == true) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.always) {
        await getLatAndLong();
      } else {
        Geolocator.requestPermission();
      }
    }
  }

  Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  @override
  void onInit() async {
    getPostion();
    yourPostion = await getLatAndLong();
    List<Placemark> placemark = await placemarkFromCoordinates(
        yourPostion.altitude, yourPostion.longitude);
    yourLocation = "${placemark[0].country}, ${placemark[0].locality}";
    super.onInit();
  }
}

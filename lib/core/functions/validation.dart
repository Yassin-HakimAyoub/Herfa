import 'package:get/get.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/strings.dart';

validInput(String val, int min, int max, String type) {
  if (type == AppConst.userName) {
    if (val.length > max) {
      return ValidationText.userNamelength;
    }
  }
  if (type == AppConst.email) {
    if (!GetUtils.isEmail(val)) {
      return ValidationText.validEmail;
    }
  }

  if (type == AppConst.worker) {
    if (val.isEmpty) {
      return ValidationText.empty;
    }
  }
  if (type == AppConst.longText) {
    if (val.isEmpty) {
      return ValidationText.empty;
    }
  }

  if (type == AppConst.phone) {
    if (!GetUtils.isPhoneNumber(val)) {
      return ValidationText.validPhoneNumber;
    }
  }

  if (type == AppConst.notificationsvalid) {
    if (val.isEmpty) {
      return "الحقل فارغ";
    } else if (val.length >= 20) {
      return "عدد الجروف كبير";
    }
  }

  if(type == "text"){
    if(val.isEmpty){
      return "الحقل فارغ";
    }
  }

  if (val.length < min) {
    return "${ValidationText.lessText} $min";
  }

  if (val.length > max) {
    return "${ValidationText.bigText} $max";
  }

  if (val.isEmpty) {
    return ValidationText.empty;
  }
}

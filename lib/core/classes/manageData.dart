import 'package:flutter/material.dart';
import 'package:services/core/constans/enums.dart';



class manageData {
  String text , path;
  IconData iconData;
  ManageType manageType;

  manageData(
      {required this.iconData, required this.manageType, required this.text , required this.path});
}

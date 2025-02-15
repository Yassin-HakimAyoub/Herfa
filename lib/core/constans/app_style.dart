import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';

class AppStyles {
  static TextStyle titelStyle() {
    return const TextStyle(
        fontFamily: AppConst.cairoFont, fontSize: 20, fontWeight: FontWeight.bold);
  }
  static TextStyle textStyle() {
    return const TextStyle(
        fontFamily: AppConst.cairoFont, fontSize: 17,);
  }
   static TextStyle textStyleColor( {required Color? color , required double size}) {
    return  TextStyle(
        fontFamily: AppConst.cairoFont, fontSize: size, color: color);
  }
  static TextStyle textBoldStyle() {
    return const TextStyle(
        fontFamily: AppConst.cairoFont, fontSize: 17, fontWeight: FontWeight.bold);
  }
  static TextStyle textBoldStyleColor({required Color? color , required double size}) {
    return  TextStyle(
        fontFamily: AppConst.cairoFont, color: color, fontSize: size, fontWeight: FontWeight.bold);
  }
  static TextStyle subTitelStyle() {
    return const TextStyle(
        fontFamily: AppConst.cairoFont, color: Colors.black38);
  }
}

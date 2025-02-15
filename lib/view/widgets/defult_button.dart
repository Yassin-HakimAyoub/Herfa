import 'package:flutter/material.dart';
import 'package:services/core/constans/app_colors.dart';

defultButton({required String text, required Function()? click}) {
  return GestureDetector(
    onTap: click,
    child: Container(
      width: 280,
      height: 50,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.appMainColor),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget MyButton(String text, Function()? onClick,
    {Color color = Colors.white, Color textColor = Colors.black}) {
  return SizedBox(
    width: 250,
    height: 50,
    child: MaterialButton(
      onPressed: onClick,
      color: color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontFamily: 'Cairo'),
      ),
    ),
  );
}

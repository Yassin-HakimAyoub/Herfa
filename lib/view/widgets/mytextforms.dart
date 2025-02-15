import 'package:flutter/material.dart';
import 'package:services/core/functions/size_func.dart';

class customTextFiled extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextInputType textInputType;
  final int lines;
  final bool isPassword;
  final TextEditingController editingController;
  final String? Function(String?) valid;
  final void Function()? chanagePass;

  const customTextFiled(
      {required this.hinttext,
      required this.valid,
      required this.editingController,
      required this.textInputType,
      required this.iconData,
      this.isPassword = false,
      this.chanagePass,
      this.lines = 1,
      required this.labeltext});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.12,
      child: TextFormField(
        keyboardType: textInputType,
        controller: editingController,
        validator: valid,
        maxLines: lines,
        obscureText: isPassword == false ? false : true,
        decoration: InputDecoration(
          labelText: labeltext,
          hintText: hinttext,
          enabledBorder: myOutlinrBorder(),
          focusedBorder: myOutlinrBorder(),
          errorBorder: myOutlinrBorder(),
          border: myOutlinrBorder(),
          disabledBorder: myOutlinrBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: InkWell(onTap: chanagePass, child: Icon(iconData)),
        ),
      ),
    );
  }
}

myOutlinrBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.black54));
}

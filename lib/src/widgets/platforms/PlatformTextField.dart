import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;

class PlatformTextField extends PlatformWidget<CupertinoTextField, TextField> {
  PlatformTextField({this.controller, this.placeholder, this.isPassword});

  final TextEditingController controller;
  final String placeholder;
  final bool isPassword;

  @override
  TextField createAndroidWidget(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      autocorrect: false,
      style: const TextStyle(
        fontFamily: fonts.primaryFF,
        color: colors.smoothLabelColor,
        fontWeight: fonts.medium,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
          fontFamily: fonts.primaryFF,
          fontSize: 16,
          color: colors.smoothLabelColor,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.smoothLabelColor,
          ),
        ),
      ),
    );
  }

  @override
  CupertinoTextField createIosWidget(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      obscureText: isPassword,
      autocorrect: false,
      placeholder: placeholder,
      style: const TextStyle(
        fontFamily: fonts.primaryFF,
        color: colors.smoothLabelColor,
        fontWeight: fonts.medium,
        fontSize: 16,
      ),
    );
  }
}

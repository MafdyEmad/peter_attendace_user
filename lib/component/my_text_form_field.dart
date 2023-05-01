import 'package:attendance/constant/constants.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final Widget? icon;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final String? hintText;
  final bool obscureText;
  final suffixIcon;
  final fillColor;
  final TextStyle? hintStyle;
  final filled;
  final String? Function(String?)? validator;

  const MyTextFormField(
      {super.key,
      this.suffixIcon,
      this.filled,
      this.fillColor,
      this.obscureText = false,
      this.controller,
      this.labelText,
      this.icon,
      this.labelStyle,
      this.style,
      this.validator,
      this.hintStyle,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      cursorColor: secondaryTextColor,
      style: const TextStyle(
        fontSize: primaryFontSize,
        color: primaryTextColor,
      ),
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle,
        icon: icon,
        labelStyle: labelStyle,
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 14, 15, 26);
const Color secondaryColor = Color.fromARGB(255, 22, 24, 35);
const Color primaryTextColor = Colors.white;
const Color secondaryTextColor = Color.fromARGB(255, 179, 180, 182);
const Color switchColor = Color.fromARGB(255, 86, 178, 186);
const primaryGradiantColor = [
  Color.fromARGB(255, 102, 113, 231),
  Color.fromARGB(255, 102, 113, 231),
  Color.fromARGB(255, 91, 178, 200),
  Color.fromARGB(255, 91, 178, 200),
];
const secondaryGradiantColor = [
  Color.fromARGB(255, 142, 77, 232),
  Color.fromARGB(255, 142, 77, 232),
  Color.fromARGB(255, 255, 35, 101),
  Color.fromARGB(255, 255, 35, 101),
];
const double primaryFontSize = 18;
const double secondaryFontSize = 14;

SnackBar mySnackBar(context, {content}) => SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * .6,
      duration: const Duration(milliseconds: 2100),
      backgroundColor: secondaryColor,
      content: content,
    );

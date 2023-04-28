import 'package:flutter/material.dart';

void showMyDialog(
    {required context,
    content,
    actions,
    title,
    barrierDismissible,
    double? elevation,
    barrierColor,
    backgroundColor}) {
  showDialog(
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: elevation,
        backgroundColor: backgroundColor,
        title: title,
        content: content,
        actions: actions,
      );
    },
  );
}

import 'package:attendance/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class MyTableCell extends StatelessWidget {
  final clock;
  final icon;
  final bool isEmpty;
  const MyTableCell({super.key, this.clock, this.icon, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: SizedBox(
        height: 81,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              isEmpty ? DateFormat("h:mm a").format(clock) : "--,--",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
                fontSize: secondaryFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

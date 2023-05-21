import 'package:attendance/component/my_table_cell.dart';
import 'package:attendance/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTable extends StatelessWidget {
  final clockInDate;
  final clockOutDate;
  final workingHours;
  const MyTable({
    super.key,
    this.workingHours,
    this.clockInDate,
    this.clockOutDate,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = DateFormat("h:mm:ss a").format(clockOutDate.toDate()) !=
        DateFormat("h:mm:ss a").format(clockInDate.toDate());

    return Table(
      children: [
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: 50,
              decoration: BoxDecoration(
                color: switchColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("dd").format(clockInDate.toDate()).toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: secondaryFontSize,
                    ),
                  ),
                  Text(
                    DateFormat("EE").format(clockInDate.toDate()).toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: secondaryFontSize,
                    ),
                  ),
                ],
              ),
            ),
            MyTableCell(
              isEmpty: clockInDate != null,
              clock: clockInDate.toDate(),
              icon: const RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  color: switchColor,
                  Icons.call_received,
                  size: 20,
                ),
              ),
            ),
            MyTableCell(
              isEmpty: isEmpty,
              clock: clockOutDate.toDate(),
              icon: const Icon(
                color: switchColor,
                Icons.call_made,
                size: 20,
              ),
            ),
            TableCell(
              child: SizedBox(
                height: 81,
                child: Center(
                  child: Text(
                    workingHours,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      fontSize: secondaryFontSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

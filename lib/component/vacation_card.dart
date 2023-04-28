import 'package:attendance/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VAcationCard extends StatelessWidget {
  final from;
  final to;
  VAcationCard({super.key, this.from, this.to});

  @override
  Widget build(BuildContext context) {
    bool isONeDay = DateFormat("dd").format(to.toDate()) ==
            DateFormat("dd").format(from.toDate())
        ? true
        : false;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 50,
      decoration: BoxDecoration(
          color: switchColor.withAlpha(100),
          borderRadius: BorderRadius.circular(8)),
      child: isONeDay
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd").format(from.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat("EEEE").format(from.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd").format(from.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  DateFormat("EEEE").format(from.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "to",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat("dd").format(to.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  DateFormat("EEEE").format(to.toDate()).toString(),
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: primaryFontSize,
                  ),
                )
              ],
            ),
    );
  }
}

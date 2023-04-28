import 'package:attendance/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MailInfo extends StatelessWidget {
  final date;
  final startTime;
  final endTime;
  final message;
  final isApproved;
  const MailInfo(
      {super.key,
      this.date,
      this.startTime,
      this.endTime,
      this.message,
      this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Date",
          style: TextStyle(
            color: switchColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          DateFormat("yyyy-MM-dd").format(date.toDate()).toString(),
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Start sime",
          style: TextStyle(
            color: switchColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          DateFormat("yyyy-MM-dd").format(startTime.toDate()).toString(),
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "End time",
          style: TextStyle(
            color: switchColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          DateFormat("yyyy-MM-dd").format(endTime.toDate()).toString(),
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Response",
          style: TextStyle(
            color: switchColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        isApproved == "waiting"
            ? const Text(
                "waiting",
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: primaryFontSize,
                ),
              )
            : isApproved == "approved"
                ? const Text(
                    "Approved",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: primaryFontSize,
                    ),
                  )
                : const Text(
                    "Rejected",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: primaryFontSize,
                    ),
                  ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Message",
          style: TextStyle(
            color: switchColor,
            fontSize: primaryFontSize,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "$message",
          style: const TextStyle(
            color: primaryTextColor,
            fontSize: primaryFontSize,
          ),
        ),
      ],
    );
  }
}

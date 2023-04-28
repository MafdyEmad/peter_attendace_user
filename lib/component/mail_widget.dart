import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/mails_page/mails_page_cubit/mails_page_cubit_screen_cubit.dart';
import 'package:attendance/pages/mails_page/mails_page_cubit/mails_page_cubit_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMail extends StatelessWidget {
  final docUid;
  final isApproved;
  final sendDate;
  final from;
  final to;
  final content;
  final vacationToDate;
  final vacationFromDate;
  const MyMail(
      {super.key,
      this.docUid,
      this.sendDate,
      this.from,
      this.to,
      this.content,
      this.vacationToDate,
      this.vacationFromDate,
      this.isApproved});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MailsScreenCubit, MailsScreenState>(
      listener: (context, state) {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Admin",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: primaryFontSize,
                          ),
                        ),
                        Text(
                          "$content",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: secondaryTextColor,
                            fontSize: secondaryFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat("h:mm a").format(sendDate.toDate()),
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: secondaryFontSize,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                isApproved == "waiting"
                    ? const Text(
                        "waiting",
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      )
                    : isApproved == "approved"
                        ? const Text(
                            "Approved",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: secondaryFontSize,
                            ),
                          )
                        : const Text(
                            "Rejected",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: secondaryFontSize,
                            ),
                          ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

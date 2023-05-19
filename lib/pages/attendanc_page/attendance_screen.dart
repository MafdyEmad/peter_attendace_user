import 'package:attendance/component/my_table.dart';
import 'package:attendance/component/vacation_card.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/models/attendance.dart';
import 'package:attendance/pages/attendanc_page/attendac_page_cubit/attendac_page_cubit_screen_states.dart';
import 'package:attendance/pages/attendanc_page/attendac_page_cubit/attendance_page_cubit_screen_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          const Text(
            "Attendance",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              fontSize: primaryFontSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AttendanceScreenCubit, AttendanceScreenState>(
                  builder: (context, state) => Text(
                    "${AttendanceScreenCubit.get(context).convertMonth(AttendanceScreenCubit.get(context).month)}, ${AttendanceScreenCubit.get(context).year}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      fontSize: primaryFontSize,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final result = await showDatePicker(
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: primaryColor,
                            onPrimary: switchColor,
                            onSurface: primaryTextColor,
                          ),
                          dialogBackgroundColor: secondaryColor,
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: switchColor,
                            ),
                          ),
                        ),
                        child: child!,
                      ),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2005),
                      lastDate: DateTime(2050),
                    );
                    if (result != null) {
                      if (context.mounted) {
                        AttendanceScreenCubit.get(context)
                            .changeDAte(m: result.month, y: result.year);
                      }
                    }
                  },
                  color: primaryTextColor,
                  icon: const Icon(
                    Icons.calendar_month,
                    color: switchColor,
                  ),
                ),
              ],
            ),
          ),
          Table(
            children: const [
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        "Clock in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        "Clock out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        "Working Hr's",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: secondaryFontSize,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AttendanceScreenCubit, AttendanceScreenState>(
            builder: (context, state) => Expanded(
              child: StreamBuilder<List<Attendance>>(
                stream: AttendanceScreenCubit.get(context).getData(
                  LoginScreenCubit.get(context).getCurrentUser()?.uid,
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data?.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Image.asset('assets/no_data.png'),
                        ),
                        const Text(
                          'No data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                            fontSize: secondaryFontSize,
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => snapshot
                                    .data[index].clockInLocation !=
                                const GeoPoint(0, 0)
                            ? MyTable(
                                clockInDate: snapshot.data[index].clockInDate,
                                clockOutDate: snapshot.data[index].clockOutDate,
                                workingHours: snapshot.data[index].workingHours,
                              )
                            : VAcationCard(
                                from: snapshot.data[index].clockInDate,
                                to: snapshot.data[index].clockOutDate,
                              ));
                  } else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.asset('assets/error.png'),
                        ),
                        const Text(
                          'An error occurred',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                            fontSize: secondaryFontSize,
                          ),
                        )
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: switchColor,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

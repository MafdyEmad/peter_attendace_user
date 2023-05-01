import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/component/clock.dart';
import 'package:attendance/component/clock_button.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/paints/working_hours.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:attendance/paints/clock_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) async {
        if (state is HomeScreenGetLocationStateLoading) {
          showMyDialog(
            backgroundColor: Colors.transparent,
            barrierColor: const Color.fromARGB(100, 10, 10, 10),
            elevation: 0,
            context: context,
            barrierDismissible: false,
            content: WillPopScope(
              onWillPop: LoginScreenCubit.get(context).onWillPop,
              child: const Center(
                child: CircularProgressIndicator(color: switchColor),
              ),
            ),
          );
        } else if (state is HomeScreenGetLocationStateFailed) {
          Navigator.pop(context);
          showMyDialog(
            backgroundColor: secondaryColor,
            barrierColor: const Color.fromARGB(100, 10, 10, 10),
            context: context,
            barrierDismissible: false,
            content: const Text(
              "Faild to get the location",
              style: TextStyle(
                fontSize: primaryFontSize,
                color: primaryTextColor,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontSize: primaryFontSize,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeScreenGetLocationStateSuccess) {
          HomeScreenCubit.get(context).clockInAndOut(context);
        } else if (state is HomeScreenClockStateFailed) {
          Navigator.pop(context);
          showMyDialog(
            backgroundColor: secondaryColor,
            barrierColor: const Color.fromARGB(100, 10, 10, 10),
            context: context,
            barrierDismissible: false,
            content: const Text(
              "Please try again",
              style: TextStyle(
                fontSize: primaryFontSize,
                color: primaryTextColor,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontSize: primaryFontSize,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ],
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: StreamBuilder(
              stream: HomeScreenCubit.get(context).getDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryTextColor,
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(color: switchColor));
                }
              },
            ),
          ),
          const Center(
            child: MyClock(),
          ),
          ClockButton(),
          StreamBuilder(
            stream: HomeScreenCubit.get(context).getClocks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CustomPaint(
                          size: const Size(30, 30),
                          painter: ClockIn(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.exists &&
                                  snapshot.data?["clock in date"] != null
                              ? DateFormat("hh:mm").format(
                                  snapshot.data!["clock in date"].toDate())
                              : "--:--",
                          style: const TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                        const Text(
                          "Clock in",
                          style: TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: CustomPaint(
                            size: const Size(30, 30),
                            painter: ClockIn(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.exists &&
                                  snapshot.data?["clock out date"] !=
                                      Timestamp.fromMicrosecondsSinceEpoch(0)
                              ? DateFormat("hh:mm").format(
                                  snapshot.data!["clock out date"].toDate())
                              : "--:--",
                          style: const TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                        const Text(
                          "Clock out",
                          style: TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomPaint(
                          size: const Size(30, 30),
                          painter: WorkingHours(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.exists &&
                                  snapshot.data!["working hours"] != null
                              ? snapshot.data!["working hours"]
                              : "--:--",
                          style: const TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                        const Text(
                          "Working Hr's",
                          style: TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        )
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text(
                  "There is an error",
                  style: TextStyle(
                      fontSize: primaryFontSize, color: primaryTextColor),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: switchColor));
              }
            },
          ),
        ],
      ),
    );
  }
}

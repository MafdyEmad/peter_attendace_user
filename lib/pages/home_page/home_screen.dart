import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/component/clock.dart';
import 'package:attendance/component/clock_button.dart';
import 'package:attendance/component/clock_design.dart';
import 'package:attendance/component/working_houers_widget.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/paints/working_hours.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:attendance/paints/clock_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = HomeScreenCubit.get(context).myBox.get("name") ?? "loading..";
    // FirebaseAuth.instance
    //     .signOut()
    //     .then(
    //       (value) async {},
    //     )
    //     .catchError(
    //       (e) {},
    //     );

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
                child: CircularProgressIndicator(),
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
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: primaryTextColor,
              ),
            ),
          ),
          const Center(
            child: MyClock(),
          ),
          ClockButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClockDesign(clock: ClockIn(), inOrOut: "in"),
              ClockDesign(
                clock: ClockIn(),
                inOrOut: "out",
                quarterTurns: 135,
              ),
              // ClockDesign(clock: ClockOut(), inOrOut: "out"),
              Column(
                children: [
                  CustomPaint(
                    size: const Size(30, 30),
                    painter: WorkingHours(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const WorkingHoursWidget(),
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
          ),
        ],
      ),
    );
  }
}

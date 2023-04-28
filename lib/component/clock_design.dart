import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ClockDesign extends StatelessWidget {
  final clock;
  final String inOrOut;
  final quarterTurns;
  const ClockDesign({
    super.key,
    required this.clock,
    required this.inOrOut,
    this.quarterTurns = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: quarterTurns,
          child: CustomPaint(
            size: const Size(30, 30),
            painter: clock,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<HomeScreenCubit, HomeScreenState>(
          buildWhen: (previous, current) =>
              current is HomeScreenClockStateSuccess,
          builder: (context, state) {
            return Text(
              HomeScreenCubit.get(context).myBox.get("clock $inOrOut") != null
                  ? DateFormat("h:mm a")
                      .format(HomeScreenCubit.get(context)
                          .myBox
                          .get("clock $inOrOut"))
                      .toString()
                  : "--:--",
              style: const TextStyle(
                fontSize: secondaryFontSize,
                color: secondaryTextColor,
              ),
            );
          },
        ),
        Text(
          "Clock $inOrOut",
          style: const TextStyle(
            fontSize: secondaryFontSize,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

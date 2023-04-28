import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      buildWhen: (previous, current) => current is HomeScreenClockStateSuccess,
      builder: (context, state) {
        return Text(
          HomeScreenCubit.get(context)
              .myBox
              .get("workingHours", defaultValue: "--:--"),
          style: const TextStyle(
            fontSize: secondaryFontSize,
            color: secondaryTextColor,
          ),
        );
      },
    );
  }
}

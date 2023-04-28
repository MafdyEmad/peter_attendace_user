import 'dart:async';

import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';

class MyClock extends StatefulWidget {
  const MyClock({super.key});

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${HomeScreenCubit.get(context).getHourMinuteFormat()}",
          style: const TextStyle(
            fontSize: 50,
            color: primaryTextColor,
          ),
        ),
        Text(
          "${HomeScreenCubit.get(context).getMontAndDayhFormat()}",
          style: const TextStyle(
            fontSize: 28,
            color: secondaryTextColor,
          ),
        )
      ],
    );
  }
}

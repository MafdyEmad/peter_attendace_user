import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockButton extends StatelessWidget {
  ClockButton({super.key});

  bool isIn = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      buildWhen: (previous, current) => current is HomeScreenClockStateSuccess,
      builder: (context, state) {
        isIn = HomeScreenCubit.get(context).read();
        return Material(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: MediaQuery.of(context).size.height * .32,
            child: Material(
              child: InkWell(
                onTap: () async {
                  await HomeScreenCubit.get(context).getAllPermission(context);
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          isIn ? secondaryGradiantColor : primaryGradiantColor,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    // gradient: isIn ? myGradiantLight : myGradiantDark,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.touch_app_outlined,
                        size: 121,
                        color: primaryTextColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        isIn ? "Clock out" : "Clock In",
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: primaryFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

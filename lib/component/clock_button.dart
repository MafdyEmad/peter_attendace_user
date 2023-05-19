import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';

class ClockButton extends StatelessWidget {
  ClockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HomeScreenCubit.get(context).getDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                    await HomeScreenCubit.get(context)
                        .getAllPermission(context);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: snapshot.data!["is in"]
                            ? secondaryGradiantColor
                            : primaryGradiantColor,
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
                          snapshot.data!["is in"] ? "Clock out" : "Clock In",
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
        } else if (snapshot.hasError) {
          return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              height: MediaQuery.of(context).size.height * .32,
              child: const Text(
                "There is an error",
                style: TextStyle(
                    color: primaryTextColor, fontSize: primaryFontSize),
              ));
        } else {
          return SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .32,
              child: const Center(
                child: CircularProgressIndicator(
                  color: switchColor,
                ),
              ));
        }
      },
    );
  }
}

import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:attendance/pages/main_page/main_screen.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Wraper extends StatelessWidget {
  const Wraper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: LoginScreenCubit.get(context).authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: HomeScreenCubit.get(context).isHasPermissionToLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data!.exists &&
                  snapshot.data!["is loged in"]) {
                return const MainScreen();
              } else if (snapshot.hasData &&
                  snapshot.data!.exists &&
                  !snapshot.data!["is loged in"]) {
                return Container(
                  color: primaryColor,
                  child: Center(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .9,
                    child: const Card(
                      color: switchColor,
                      child: Center(
                        child: Text(
                          "Waiting for admin permission..",
                          style: TextStyle(
                              color: primaryTextColor,
                              fontSize: primaryFontSize),
                        ),
                      ),
                    ),
                  )),
                );
              } else {
                return Container(
                    color: primaryColor,
                    child: const Center(child: CircularProgressIndicator()));
              }
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

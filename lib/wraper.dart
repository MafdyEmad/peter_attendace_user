import 'package:attendance/pages/main_page/main_screen.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

class Wraper extends StatelessWidget {
  const Wraper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: LoginScreenCubit.get(context).authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

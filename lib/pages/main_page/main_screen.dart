import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/main_page/main_screen_cubit/main_screen_cubit.dart';
import 'package:attendance/pages/main_page/main_screen_cubit/main_screen_state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   MainScreenCubit.get(context).changePage(2);
    // });
    return BlocBuilder<MainScreenCubit, MainScreenStates>(
      builder: (context, state) => Scaffold(
        backgroundColor: primaryColor,
        bottomNavigationBar: CurvedNavigationBar(
          index: MainScreenCubit.get(context).pageNumber,
          onTap: (value) => MainScreenCubit.get(context).changePage(value),
          height: 75,
          buttonBackgroundColor: switchColor,
          color: secondaryColor,
          backgroundColor: primaryColor,
          items: const [
            Icon(
              Icons.home,
              color: primaryTextColor,
            ),
            Icon(
              Icons.list_alt,
              color: primaryTextColor,
            ),
            Icon(
              Icons.mail,
              color: primaryTextColor,
            ),
            Icon(
              Icons.money,
              color: primaryTextColor,
            ),
          ],
        ),
        body: MainScreenCubit.get(context)
            .pages[MainScreenCubit.get(context).pageNumber],
      ),
    );
  }
}

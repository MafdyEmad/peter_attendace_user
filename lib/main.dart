import 'package:attendance/pages/mails_page/mails_page_cubit/mails_page_cubit_screen_cubit.dart';
import 'package:attendance/pages/salary_page/salary_screen_cubit.dart';
import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_cubit.dart';
import 'pages/attendanc_page/attendac_page_cubit/attendance_page_cubit_screen_cubit.dart';
import 'package:attendance/pages/main_page/main_screen_cubit/main_screen_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'pages/home_page/home_page_cubit/home_screen_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance/wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox('user');
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => HomeScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => MainScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => SettingsScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => AttendanceScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => MailsScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => SalaryScreenCubit(context),
        ),
      ],
      child: const MaterialApp(
        // darkTheme: MyThemes.get().currentTheme(),
        home: Wraper(),
      ),
    );
  }
}

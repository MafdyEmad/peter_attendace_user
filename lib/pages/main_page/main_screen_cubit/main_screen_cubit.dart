import 'package:attendance/pages/attendanc_page/attendance_screen.dart';
import 'package:attendance/pages/home_page/home_screen.dart';
import 'package:attendance/pages/main_page/main_screen_cubit/main_screen_state.dart';
import 'package:attendance/pages/salary_page/salary_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings_page/ssetting_screen.dart';

class MainScreenCubit extends Cubit<MainScreenStates> {
  final context;
  MainScreenCubit(this.context) : super(MainScreenInitStates());
  static MainScreenCubit get(context) => BlocProvider.of(context);
  List pages = [
    const HomeScreen(),
    const AttendanceScreen(),
    // MailsScreen(),
    const SalaryScreen(),
    const SettingsScreen()
  ];
  int pageNumber = 0;
  void changePage(int value) {
    pageNumber = value;
    emit(MaincreenChangePage());
  }
}

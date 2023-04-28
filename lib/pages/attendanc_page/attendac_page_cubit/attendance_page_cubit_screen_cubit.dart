import 'package:attendance/models/attendance.dart';
import 'package:attendance/pages/attendanc_page/attendac_page_cubit/attendac_page_cubit_screen_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreenCubit extends Cubit<AttendanceScreenState> {
  final context;
  AttendanceScreenCubit(this.context) : super(AttendanceScreenInitState());

  static AttendanceScreenCubit get(context) => BlocProvider.of(context);

  String date = "${DateTime.now().month}, ${DateTime.now().year}";
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  void changeDAte({m, y}) {
    month = m;
    year = y;
    emit(AttendanceScreenChangeDateState());
  }

  String convertMonth(month) {
    switch (month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return month;
  }

  Stream<List<Attendance>>? getData(
    uid,
  ) {
    try {
      return FirebaseFirestore.instance
          .collection("employees")
          .doc("$uid")
          .collection("attendance")
          .where("date", isEqualTo: "$month, $year")
          .orderBy('clock in date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Attendance.fromJson(doc.data()))
              .toList());
    } catch (e) {
      print("error");
    }
  }
}

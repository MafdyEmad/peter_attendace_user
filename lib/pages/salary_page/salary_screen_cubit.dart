import 'package:attendance/pages/salary_page/salary_Screen_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/deductions.dart';
import '../sign_in_page/sign_in_cubit/sign_in_cubit.dart';

class SalaryScreenCubit extends Cubit<SalaryScreenStates> {
  final context;
  SalaryScreenCubit(this.context) : super(SalaryScreenInitStates());
  static SalaryScreenCubit get(context) => BlocProvider.of(context);
  //deductions

  // Future getSalary() async {
  //   try {
  //     final doc = await FirebaseFirestore.instance
  //         .collection("employees")
  //         .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
  //         .get();

  //     return doc.get("salary");
  //   } catch (e) {}
  // }

  // Future getTotalSalary() async {
  //   final totalWorkingHours =
  //       await HomeScreenCubit.get(context).getTotalWorkingHours();
  //   final salary = await getSalary();
  //   totalSalary = totalWorkingHours * salary;

  //   return totalSalary;
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getTotalSalary() {
    try {
      return FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .snapshots();
    } catch (e) {}
  }

  Stream<List<Deductions>>? getData(uid) {
    try {
      return FirebaseFirestore.instance
          .collection("employees")
          .doc("$uid")
          .collection("deductions")
          .orderBy("date", descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Deductions.fromJson(doc.data()))
              .toList());
    } catch (e) {
      print("error");
    }
  }
}

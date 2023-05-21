import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/constants.dart';
import 'package:attendance/models/mail_model.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mails_page_cubit_screen_states.dart';

class MailsScreenCubit extends Cubit<MailsScreenState> {
  final context;
  MailsScreenCubit(this.context) : super(AttendanceScreenInitState());

  static MailsScreenCubit get(context) => BlocProvider.of(context);

  DateTime vacatioFromDAte = DateTime.now();
  DateTime vacatioToDAte = DateTime.now();

  Stream<List<Mail>>? getData(uid) {
    try {
      return FirebaseFirestore.instance
          .collection("employees")
          .doc("$uid")
          .collection("mails")
          .orderBy("send date", descending: true)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Mail.fromJson(doc.data())).toList());
    } catch (e) {
      print("error");
    }
  }

  void getVacation({from, to}) {
    vacatioFromDAte = from;
    vacatioToDAte = to;
    emit(MailScreenGetVacationState());
  }

  void cancelVacation() {
    vacatioFromDAte = DateTime.now();
    vacatioToDAte = DateTime.now();
    // vacatioFromDAte = DateTime.utc(0);
    // vacatioToDAte = DateTime.utc(0);
    emit(MailScreenCancelVacationState());
  }

  Future getUserName() async {
    final result = await FirebaseFirestore.instance
        .collection('employees')
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .get();
    return result.get("name");
  }

  Future<void> sendNotification({title, body}) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAI0CRMjI:APA91bGUger_YmxG3MbSsjlElM_lgHSiXzbk29GN0SQUiQFSrSq6uV2p_UVURLMMxv-oWZYAxMAjbED1NadxnMBXOgC2vex5EcwJNWvDJdJyNc-LN9KLyYN6IIImj83Fj1kZpb-08uvt",
        },
        body: jsonEncode(
          {
            "to": "/topics/admin",
            "priority": "high",
            "notification": {
              "title": "$title",
              "body": "$body",
              "subtitle": "",
            }
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future senMailToAdmin(context, {dateFrom, dateTo, content, uid}) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        final name = await getUserName();
        emit(MailScreenSendMailLoadingState());
        final adminDuc = FirebaseFirestore.instance
            .collection("admins")
            .doc("mails")
            .collection("mails")
            .doc();

        final userDoc = FirebaseFirestore.instance
            .collection("employees")
            .doc(LoginScreenCubit.get(context).getCurrentUser()?.uid)
            .collection("mails")
            .doc();
        await adminDuc.set(Mail(
                senderName: name,
                // await HomeScreenCubit.get(context).myBox.get("name"),
                isApproved: "waiting",
                adminDocUid: adminDuc.id,
                userDocUid: userDoc.id,
                vacationToDate: dateTo,
                vacationFromDate: dateFrom,
                content: content,
                sendDate: DateTime.now(),
                from: uid,
                to: "admin")
            .toJson());

        await userDoc.set(Mail(
          senderName: name,
          //  await HomeScreenCubit.get(context).myBox.get("name"),
          isApproved: "waiting",
          adminDocUid: adminDuc.id,
          userDocUid: userDoc.id,
          vacationToDate: dateTo,
          vacationFromDate: dateFrom,
          content: content,
          sendDate: DateTime.now(),
          from: uid,
          to: "admin",
        ).toJson());

        await sendNotification(
            title: name,
            // HomeScreenCubit.get(context).myBox.get("name"),
            body: "$content");

        emit(MailScreenSendMailSuccessState());
      } catch (e) {
        emit(MailScreenSendMailFailedState());
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(
          context,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('No internet connection'),
              Icon(
                Icons.wifi,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
  }
}

import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_states.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../component/alert_dialog.dart';
import '../../../constant/constants.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenStates> {
  final context;
  SettingsScreenCubit(this.context) : super(SettingsScreenInitStates());
  static SettingsScreenCubit get(context) => BlocProvider.of(context);
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future chnagePassword(
      {currentPasswordController, newPasswordController}) async {
    showMyDialog(
      backgroundColor: Colors.transparent,
      barrierColor: const Color.fromARGB(100, 0, 0, 0),
      context: context,
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: LoginScreenCubit.get(context).onWillPop,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await logIn(currentPasswordController)
        .then((value) async => changeToCurrentPassword(newPasswordController)
                .then((value) async =>
                    await updatePassword(newPasswordController))
                .then((value) async {
              // await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                mySnackBar(
                  context,
                  content: const Center(
                    child: Text(
                      "password changed successfully",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: secondaryFontSize,
                      ),
                    ),
                  ),
                ),
              );
            }))
        .catchError((e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(
          context,
          content: const Center(
            child: Text(
              "Faild to change the password",
              style: TextStyle(
                color: Colors.red,
                fontSize: secondaryFontSize,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future logIn(currentPasswordController) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: getEmail(), password: currentPasswordController)
        .catchError((e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(
          context,
          content: const Center(
            child: Text(
              "Current password is wrong",
              style: TextStyle(
                color: Colors.red,
                fontSize: secondaryFontSize,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future updatePassword(newPasswordController) async {
    await FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit(context).getCurrentUser()!.uid)
        .update({"password": newPasswordController}).catchError((e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(
          context,
          content: const Center(
            child: Text(
              "Faild to change the password",
              style: TextStyle(
                color: Colors.red,
                fontSize: secondaryFontSize,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future changeToCurrentPassword(newPasswordController) async {
    await FirebaseAuth.instance.currentUser!
        .updatePassword(newPasswordController)
        .catchError((e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(
          context,
          content: const Center(
            child: Text(
              "Faild to change the password",
              style: TextStyle(
                color: Colors.red,
                fontSize: secondaryFontSize,
              ),
            ),
          ),
        ),
      );
    });
  }

  String getEmail() => FirebaseAuth.instance.currentUser!.email.toString();

  void c() {
    emit(SettingsScreenChangePasswordFailedState());
  }
}

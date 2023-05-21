import 'dart:async';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates> {
  final context;
  LoginScreenCubit(this.context) : super(LoginScreenInitState());
  final _auth = FirebaseAuth.instance;

  static LoginScreenCubit get(context) => BlocProvider.of(context);

  User? getCurrentUser() => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  bool hasInternet = false;
  bool isPasswordVisible = false;
  // Box myBox = Hive.box("user");

  Future signIn(context,
      {required String email, required String password}) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      emit(LoginScreenStateLoading());
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          saveTheToken(uid: value.user!.uid.toString())
              .then((value) => checkIfLoggedIn()
                      .then((value) => emit(LoginScreenStateSuccess()))
                      .catchError((e) {
                    LoginScreenStateFailed(error: "Error");
                  }))
              .catchError((e) {
            LoginScreenStateFailed(error: "Error");
          });
          // saveUser();
        },
      ).catchError((e) {
        emit(LoginScreenStateFailed(error: e.toString()));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

  // Future saveUser() async {
  //   final uid = await FirebaseFirestore.instance
  //       .collection("employees")
  //       .doc(getCurrentUser()?.uid)
  //       .get()
  //       .then((value) async {
  //     // await myBox.put("name", value.get("name"));
  //   }).catchError((e) => throw e);
  // }

  Future saveTheToken({uid}) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await FirebaseFirestore.instance
          .collection("employees")
          .doc(uid)
          .update({"token": await messaging.getToken()});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> onWillPop() async {
    return false;
  }

  void showPassword() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginScreenStateShowPassword());
  }

  Future checkIfLoggedIn() async {
    await FirebaseFirestore.instance
        .collection("employees")
        .doc(_auth.currentUser!.uid)
        .update({"is loged in": false});
  }
}

import 'dart:async';
import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/models/attendance.dart';
import 'package:attendance/pages/home_page/home_page_cubit/home_screen_states.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final context;
  HomeScreenCubit(this.context) : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  Box myBox = Hive.box("user");
  LocationPermission? locationPermission;
  bool isLocationEnabled = false;
  bool isIn = false;

  //int desierdDistance = 50;
  //int distance = 0;

  double ltitude = 0.0;
  double longitude = 0.0;
  String clock = 'Clock in';

  LinearGradient gradient = const LinearGradient(
    colors: primaryGradiantColor,
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  final hourMinuteFormat = DateFormat("h:mm a");
  final montAndDayhFormat = DateFormat("EEEE, LLL dd");

  getHourMinuteFormat() => hourMinuteFormat.format(DateTime.now());
  getMontAndDayhFormat() => montAndDayhFormat.format(DateTime.now());

  int pageNumber = 0;
  void changePage(int value) {
    pageNumber = value;
    emit(HomeScreenChangePage());
  }

  Future getLocationPermission() async {
    await Geolocator.requestPermission().then((value) {
      locationPermission = value;
    }).catchError((e) {
      print("error getLocationPermission");
    });
  }

  Future openLocationSettings() async {
    await Geolocator.openLocationSettings().then(
      (value) {
        print(value);
      },
    ).catchError((e) {
      print("error openLocationSettings");
    });
  }

  Future isLocationServiceEnabled() async {
    await Geolocator.isLocationServiceEnabled().then((value) {
      isLocationEnabled = value;
    });
  }

  Future openAppSettings() async {
    await Geolocator.openAppSettings().then(
      (value) {
        print(value);
      },
    ).catchError((e) {
      print("error openAppSettings");
    });
  }

  // void getDictance(
  //     {required startLatitude,
  //     required startLongitude,
  //     required endLatitude,
  //     required endLongitude}) {
  //   distance = Geolocator.distanceBetween(
  //     startLatitude,
  //     startLongitude,
  //     endLatitude,
  //     endLongitude,
  //   ).toInt();
  // }

  Future getCurrentLocation() async {
    emit(HomeScreenGetLocationStateLoading());
    await Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 5),
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) async {
      ltitude = value.latitude;
      longitude = value.longitude;

      //print({ltitude, longitude});
      emit(HomeScreenGetLocationStateSuccess());
    }).catchError((e) {
      print("error getCurrentLocation");
      emit(HomeScreenGetLocationStateFailed());
    });
  }

//*****************************************************************************
  Future clockIn(context, {required uid}) async {
    final time = await NTP.now();
    final docUid = FirebaseFirestore.instance
        .collection("employees")
        .doc("$uid")
        .collection("attendance")
        .doc();
    await docUid
        .set(
      Attendance(
        clockOutDate: await NTP.now(),
        docUid: docUid.id,
        date: "${DateTime.now().month}, ${DateTime.now().year}",
        clockInLocation: GeoPoint(ltitude, longitude),
        clockInDate: time,
      ).toJson(),
    )
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .update({"is in": true}).then((value) {
        emit(HomeScreenClockStateSuccess());
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackBar(
            context,
            content: const Center(
              child: Text(
                'You are in',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: secondaryFontSize,
                ),
              ),
            ),
          ),
        );
      }).catchError((e) {
        emit(HomeScreenClockStateFailed());
      });

      await myBox.put("docId", docUid.id).catchError((e) {
        print("box error");
      });

      await myBox.put("clock in", time).catchError((e) {
        print("box error");
      });

      // await myBox.put("clock out", null).catchError((e) {
      //   print("box error");
      // });
      // myBox.put("workingHours", "--:--").catchError((e) {
      //   print("box error");
      // });
    }).catchError((e) {
      emit(HomeScreenClockStateFailed());
    });
  }

//*************************************************************
  Future clockOut(context, {required uid}) async {
    final time = await NTP.now();
    emit(HomeScreenGetLocationStateLoading());

    Duration _workingHours = time.difference(DateTime.parse(
        myBox.get("clock in").toString())); ////////////////////////
    _workingHours > Duration.zero
        ? _workingHours = _workingHours
        : _workingHours = Duration(
            hours: _workingHours.inHours + 24,
            minutes: _workingHours.inMinutes % 60);

    await FirebaseFirestore.instance
        .collection("employees")
        .doc("$uid")
        .collection("attendance")
        .doc(myBox.get("docId"))
        .update({
      "working hours":
          "${_workingHours.inHours}:${_workingHours.inMinutes.remainder(60)}",
      "clock out location": GeoPoint(ltitude, longitude),
      "clock out date":
          time ////////////////////////////////////////////////////
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .update({"is in": false}).then((value) async {
        await updateTotalWorkingHours(_workingHours).then((value) {
          emit(HomeScreenClockStateSuccess());
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              content: const Center(
                child: Text(
                  'You are out',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: secondaryFontSize,
                  ),
                ),
              ),
            ),
          );
        }).catchError((e) {
          emit(HomeScreenClockStateFailed());
        });
      }).catchError((e) {
        emit(HomeScreenClockStateFailed());
      });
      // await myBox.put("clock out", DateTime.now()).catchError((e) {
      //   print("box error");
      // });
      // myBox
      //     .put("workingHours",
      //         "${_workingHours.inHours}:${_workingHours.inMinutes.remainder(60)}")
      //     .then((value) async =>
      //         await updateTotalWorkingHours(_workingHours).then(
      //           (value) async {},
      //         ))
      //     .catchError((e) {
      //   print("box error");
      // });
    }).catchError((e) {
      emit(HomeScreenClockStateFailed());
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getClocks() {
    return FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .collection("attendance")
        .doc(myBox.get("docId"))
        .snapshots();
  }

  Future getAllPermission(context) async {
    await getLocationPermission();
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      await isLocationServiceEnabled();
    } else {
      showMyDialog(
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              locationPermission == LocationPermission.deniedForever
                  ? "Cancel"
                  : "Deny",
            ),
          ),
          TextButton(
            onPressed: locationPermission == LocationPermission.deniedForever
                ? () async {
                    Navigator.pop(context);
                    await openAppSettings();
                  }
                : () async {
                    Navigator.pop(context);
                    await getLocationPermission();
                  },
            child: Text(locationPermission == LocationPermission.deniedForever
                ? "Open app settings"
                : "Allow"),
          ),
        ],
        barrierDismissible: false,
        context: context,
        title: const Center(
          child: Icon(
            Icons.location_on,
          ),
        ),
        content: const Text(
          "Allow the app to access this device location?",
        ),
      );
    }

    if (isLocationEnabled) {
      await getCurrentLocation();

      // getDictance(
      //   startLatitude: ltitude,
      //   startLongitude: longitude,
      //   endLatitude: 27.933245639304648,
      //   endLongitude: 30.82116415612841,
      // );
    } else {
      showMyDialog(
        barrierColor: const Color.fromARGB(120, 0, 0, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              openLocationSettings();
            },
            child: const Text("Open location settings"),
          ),
        ],
        barrierDismissible: false,
        context: context,
        title: const Center(
          child: Icon(
            Icons.location_on,
          ),
        ),
        content: const Text(
          "Turn on the device location",
        ),
      );
    }
  }

  Future clockInAndOut(context) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      if (!await read()) {
        await clockIn(
            uid: LoginScreenCubit.get(context).getCurrentUser()?.uid, context);
      } else if (await read()) {
        clockOut(
            uid: LoginScreenCubit.get(context).getCurrentUser()?.uid, context);
      }

      // if (distance < desierdDistance && !read()) {
      //   await clockIn(
      //     uid: LoginScreenCubit.get(context).getCurrentUser()?.uid,
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: Colors.green,
      //       content: Text('You are in'),
      //     ),
      //   );
      // } else if (distance > desierdDistance && !read()) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: Colors.red,
      //       content: Text(
      //         'You are not in range',
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ),
      //   );
      // } else if (distance > desierdDistance && read()) {
      //   await clockOut(
      //     uid: LoginScreenCubit.get(context).getCurrentUser()?.uid,
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: Colors.green,
      //       content: Text('You are out'),
      //     ),
      //   );
      // } else if (distance < desierdDistance && read()) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: Colors.red,
      //       content: Text('You are stile inside'),
      //     ),
      //   );
      // }
    } else {
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
    Navigator.pop(context);
  }

  // Future<void> write(bool isIN) async {
  //   await myBox
  //       .put("uid", FirebaseAuth.instance.currentUser?.uid.toString())
  //       .catchError((e) {
  //     print("box error");
  //   });
  // }

  Future<bool> read() async {
    final result = await FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .get();
    return result.get("is in");
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getDetails() {
    return FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .snapshots();
  }

  Future getSalary() async {
    final doc = await FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .get();

    return (doc.get("salary") / 60);
  }

  Future getTotalWorkingHours() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .get();

      return doc.get("total working hours");
    } catch (e) {
      print("eeeeee $e");
    }
  }

  Future updateTotalWorkingHours(Duration time) async {
    try {
      await FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .update({
        "total working hours": await getTotalWorkingHours() + time.inMinutes
      });

      await updateTotalSalary(
          salary: await getSalary(),
          workingHours: await getTotalWorkingHours());
    } catch (e) {
      print(e);
    }
  }

/*
 Future updateTotalWorkingHours() async {
    try {
      String _workingHours = myBox.get("workingHours");
      if (_workingHours != "--:--") {
        _workingHours = _workingHours.replaceAll(":", ".");
       

        final doc = await FirebaseFirestore.instance
            .collection("employees")
            .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
            .update({
          "total working hours":
              await getTotalWorkingHours() + double.parse(_workingHours)
        });
      }
      await updateTotalSalary(
          salary: await getSalary(),
          workingHours: await getTotalWorkingHours());
    } catch (e) {}
  }*/
  Future updateTotalSalary({workingHours, salary}) async {
    try {
      await FirebaseFirestore.instance
          .collection("employees")
          .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
          .update({"total salary": (salary * workingHours).round()});
    } catch (e) {}
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> isHasPermissionToLogin() {
    return FirebaseFirestore.instance
        .collection("employees")
        .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
        .snapshots();
  }
}

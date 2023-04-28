// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class MyThemes {
//   static MyThemes get() => MyThemes();

//   final themeBox = Hive.box("user");

//   final darkTheme = ThemeData.dark();
//   final lightTheme = ThemeData.light();

//   Future<void> changeTheme(isDark) async {
//     await themeBox.put("isDark", isDark).catchError((e) {
//       print("theme error");
//     });
//   }

//   ThemeData currentTheme() {
//     final isDark = themeBox.get("isDark", defaultValue: false);
//     if (isDark) {
//       return darkTheme;
//     } else {
//       return lightTheme;
//     }
//   }
// }

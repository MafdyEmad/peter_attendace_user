// import 'package:attendance/component/alert_dialog.dart';
// import 'package:attendance/constant/constants.dart';
// import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_cubit.dart';
// import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_states.dart';
// import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
// import 'package:attendance/pages/sign_in_page/sign_in_screen.dart';
// import 'package:attendance/themes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   // @override
//   // void initState() {
//   //   SettingsScreenCubit.get(context).switchValue =
//   //       MyThemes.get().themeBox.get("isDark", defaultValue: false);
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SettingsScreenCubit, SettingsScreenStates>(
//       listener: (context, state) {
//         if (state is SettingsScreenSignOutLoadingState) {
//           showMyDialog(
//             backgroundColor: Colors.transparent,
//             barrierColor: const Color.fromARGB(100, 0, 0, 0),
//             context: context,
//             barrierDismissible: false,
//             content: WillPopScope(
//               onWillPop: LoginScreenCubit.get(context).onWillPop,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         } else if (state is SettingsScreenSignOutFailedState) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             mySnackBar(
//               context,
//               content: const Center(
//                 child: Text(
//                   "Faild to sign out",
//                   style: TextStyle(
//                     color: primaryTextColor,
//                     fontSize: secondaryFontSize,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } else if (state is SettingsScreenSignOutSuccessState) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const LoginPage(),
//             ),
//           );
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     const Text(
//             //       "Dark mode",
//             //       style: TextStyle(
//             //         fontSize: primaryFontSize,
//             //         color: primaryTextColor,
//             //       ),
//             //     ),
//             //     BlocBuilder<SettingsScreenCubit, SettingsScreenStates>(
//             //       builder: (context, state) => Switch.adaptive(
//             //         activeColor: const Color.fromARGB(255, 62, 130, 224),
//             //         value: SettingsScreenCubit.get(context).switchValue,
//             //         onChanged: (value) {
//             //           SettingsScreenCubit.get(context).chnageTheme(value);
//             //         },
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             const SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               onTap: () async {
//                 await SettingsScreenCubit.get(context).signOut();

//                 // SettingsScreenCubit.get(context)
//                 //     .signOut()
//                 //     .then((value) => Navigator.pushReplacement(
//                 //           context,
//                 //           MaterialPageRoute(
//                 //             builder: (context) => const LoginPage(),
//                 //           ),
//                 //         ));
//               },
//               child: const Text(
//                 "Log Out",
//                 style: TextStyle(
//                   color: primaryTextColor,
//                   fontSize: primaryFontSize,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

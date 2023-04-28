// import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_states.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SettingsScreenCubit extends Cubit<SettingsScreenStates> {
//   final context;
//   SettingsScreenCubit(this.context) : super(SettingsScreenInitStates());
//   static SettingsScreenCubit get(context) => BlocProvider.of(context);

//   Future signOut() async {
//     emit(SettingsScreenSignOutLoadingState());
//     await FirebaseMessaging.instance.deleteToken().then(
//       (value) {
//         FirebaseAuth.instance.signOut().then(
//           (value) async {
//             emit(SettingsScreenSignOutSuccessState());
//           },
//         ).catchError(
//           (e) {
//             emit(SettingsScreenSignOutFailedState());
//           },
//         );
//       },
//     );
//     // await FirebaseFirestore.instance
//     //     .collection("users")
//     //     .doc(LoginScreenCubit.get(context).getCurrentUser()!.uid)
//     //     .update({"token": ""});
//   }

//   // bool switchValue = false;
//   // void chnageTheme(isDark) {
//   //   switchValue = !switchValue;
//   //   MyThemes.get().changeTheme(isDark);
//   //   emit(SettingsScreenChangeTheme());
//   // }
// }

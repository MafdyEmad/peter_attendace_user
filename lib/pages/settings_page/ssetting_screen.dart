import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/component/my_text_form_field.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/settings_page/settings_screen_cubit/settings_screen_cubit.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: TextButton(
            onPressed: () {
              showMyDialog(
                backgroundColor: primaryColor,
                barrierColor: const Color.fromARGB(100, 0, 0, 0),
                context: context,
                barrierDismissible: true,
                content: Form(
                  key: SettingsScreenCubit.get(context).formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Current password",
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: primaryFontSize,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 100,
                        child: MyTextFormField(
                          fillColor: secondaryColor,
                          filled: true,
                          controller: currentPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const Text(
                        "New password",
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: primaryFontSize,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 100,
                        child: MyTextFormField(
                          fillColor: secondaryColor,
                          filled: true,
                          controller: newPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              switchColor,
                            ),
                          ),
                          onPressed: () async {
                            if (SettingsScreenCubit.get(context)
                                .formKey
                                .currentState!
                                .validate()) {
                              await SettingsScreenCubit(context).chnagePassword(
                                  currentPasswordController:
                                      currentPasswordController.text,
                                  newPasswordController:
                                      newPasswordController.text);
                              FocusNode().unfocus();
                            }
                          },
                          child: const Text(
                            "Change",
                            style: TextStyle(
                              fontSize: primaryFontSize,
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            child: const Text(
              "Change password",
              style: TextStyle(
                color: primaryTextColor,
                fontSize: primaryFontSize,
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:attendance/component/alert_dialog.dart';
import 'package:attendance/component/my_text_form_field.dart';
import 'package:attendance/constant/constants.dart';
import 'package:attendance/pages/main_page/main_screen.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_cubit.dart';
import 'package:attendance/pages/sign_in_page/sign_in_cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<LoginScreenCubit, LoginScreenStates>(
      listener: (context, state) async {
        if (state is LoginScreenStateSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        } else if (state is LoginScreenStateFailed) {
          showMyDialog(
            backgroundColor: secondaryColor,
            barrierColor: const Color.fromARGB(110, 10, 10, 10),
            context: context,
            title: const Text(
              "Faild to log in",
              style: TextStyle(
                fontSize: primaryFontSize,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
            content: const Text(
              "invalid email or password",
              style: TextStyle(
                fontSize: primaryFontSize,
                color: primaryTextColor,
              ),
            ),
            barrierDismissible: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: primaryFontSize,
                      color: switchColor,
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 100,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: primaryGradiantColor,
                          //  [
                          //   Color.fromARGB(255, 62, 130, 224),
                          //   Color.fromARGB(255, 154, 135, 228)
                          // ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                        ),
                    ),
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 60,
                        width: double.infinity,
                        child: MyTextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter an email";
                            } else {
                              return null;
                            }
                          },
                          hintText: "User Name",
                          hintStyle: const TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        width: double.infinity,
                        child: MyTextFormField(
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                LoginScreenCubit.get(context).showPassword(),
                            child:
                                LoginScreenCubit.get(context).isPasswordVisible
                                    ? const Icon(
                                        Icons.visibility_rounded,
                                        color: switchColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: secondaryTextColor,
                                      ),

                            // IconButton(
                            //   icon: LoginScreenCubit.get(context)
                            //           .isPasswordVisible
                            //       ? const Icon(
                            //           Icons.visibility_rounded,
                            //           color: switchColor,
                            //         )
                            //       : const Icon(
                            //           Icons.visibility_off,
                            //           color: secondaryTextColor,
                            //         ),
                            //   onPressed: () {},
                            // ),
                          ),
                          obscureText:
                              LoginScreenCubit.get(context).isPasswordVisible
                                  ? false
                                  : true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            } else {
                              return null;
                            }
                          },
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontSize: secondaryFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'Forgot password?',
                      //     style: TextStyle(
                      //       foreground: Paint()
                      //         ..shader = const LinearGradient(
                      //           colors: primaryGradiantColor,
                      //           // colors: [
                      //           //   Color.fromARGB(255, 62, 130, 224),
                      //           //   Color.fromARGB(255, 154, 135, 228)
                      //           // ],
                      //           begin: Alignment.topRight,
                      //           end: Alignment.bottomLeft,
                      //         ).createShader(
                      //           const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                      //         ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      // botton
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Material(
                          child: InkWell(
                            onTap: state is! LoginScreenStateLoading
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      await LoginScreenCubit.get(context)
                                          .signIn(
                                        context,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  }
                                : null,
                            child: Ink(
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: primaryGradiantColor,
                                  // colors: [
                                  //   Color.fromARGB(255, 62, 130, 224),
                                  //   Color.fromARGB(255, 154, 135, 228)
                                  // ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                              child: state is LoginScreenStateLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Loading",
                                            style: TextStyle(
                                              fontSize: primaryFontSize,
                                              color: primaryTextColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: primaryFontSize,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

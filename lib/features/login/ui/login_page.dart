// ignore_for_file: unrelated_type_equality_checks

import 'package:e_commerce_app/components/custom_textfield.dart';
import 'package:e_commerce_app/components/password_textfield.dart';
import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/features/login/ui/widget/sign_in_button.dart';
import 'package:e_commerce_app/features/register/ui/register_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listenWhen: (previous, current) => current is LoginActionState,
        buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is LoginPageNavigateToRegisterPageActionState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const RegisterPage(),
              ),
            );
          } else if (state is LoginInvalidInputActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Fill out all fields"),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is LoginSuccessfulActionState) {
            Navigator.pop(context);
            Navigator.popUntil(context, (route) => route == const LoginPage());
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const BottomNavigationPage(index: 0),
            );
          } else if (state is LoginErrorActionState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade400,
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is LoginSuccessfulLoadingActionState) {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 3,
                    color: AppColors.backgroundColor.withOpacity(0.7),
                    strokeCap: StrokeCap.round,
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.backgroundColor.withOpacity(0.7),
                        image: const DecorationImage(
                          image: AssetImage("assets/e-logo-2.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome to Shop Vista",
                      style: MyTextThemes.myTextTheme().titleMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sign in to continue",
                      style: MyTextThemes.myTextTheme().bodySmall,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      icon: Icons.mail_outline_rounded,
                      text: "Your Email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextField(controller: _passwordController),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        loginBloc.add(
                          LoginPageSignInButtonClickedEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      text: "Sign in",
                      displayPrefixImage: false,
                    ),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Text(
                      "Sign in with",
                      style: MyTextThemes.myTextTheme().bodySmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        "assets/google.svg",
                        height: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: AppColors.backgroundColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: "Poppins",
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => loginBloc
                              .add(LoginPageNavigateToRegisterPageEvent()),
                          child: Text(
                            " Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Poppins",
                              color: AppColors.backgroundColor.withOpacity(0.7),
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
      ),
    );
  }
}

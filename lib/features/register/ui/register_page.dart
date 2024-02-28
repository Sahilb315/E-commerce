// ignore_for_file: unrelated_type_equality_checks

import 'package:e_commerce_app/components/custom_textfield.dart';
import 'package:e_commerce_app/components/password_textfield.dart';
import 'package:e_commerce_app/components/phone_num_textfield.dart';
import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/login/ui/login_page.dart';
import 'package:e_commerce_app/features/login/ui/widget/sign_in_button.dart';
import 'package:e_commerce_app/features/register/bloc/register_bloc.dart';
import 'package:e_commerce_app/features/register/model/user_model.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final registerBloc = RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        listenWhen: (previous, current) => current is RegisterActionState,
        buildWhen: (previous, current) => current is! RegisterActionState,
        listener: (context, state) {
          if (state is RegisterNavigatToLoginPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve),
                  );
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (state is RegisterInvalidInputActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
                content: const Text("Fill out all fields"),
              ),
            );
          } else if (state is RegisterSuccessfulActionState) {
            Navigator.popUntil(
                context, (route) => route == const RegisterPage());
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BottomNavigationPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (state is RegisterLoadingActionState) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.07,
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
                      "Let's Get Started",
                      style: MyTextThemes.myTextTheme().titleMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Create an new account",
                      style: MyTextThemes.myTextTheme().bodySmall,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextField(
                      controller: _usernameController,
                      text: "Full Name",
                      icon: CupertinoIcons.person,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      text: "Your Email",
                      icon: Icons.mail_outline_rounded,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PhoneNumberTextField(
                      controller: _phoneNumberController,
                      text: "Phone Number",
                      inputType: TextInputType.phone,
                      maxNumbers: 10,
                      icon: CupertinoIcons.phone,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordTextField(controller: _passwordController),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInButton(
                      text: "Sign Up",
                      displayPrefixImage: false,
                      onTap: () {
                        registerBloc.add(
                          RegisterButtonClickedEvent(
                            password: _passwordController.text,
                            user: UserModel(
                              fullName: _usernameController.text,
                              email: _emailController.text,
                              profilePic:
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrqXupCTrejPvp9bruowwUwsPl1njGTqD78w&usqp=CAU",
                              phoneNumber:
                                  _phoneNumberController.text.toString(),
                              favProducts: [],
                            ),
                          ),
                        );
                        _usernameController.clear();
                        _emailController.clear();
                        _phoneNumberController.clear();
                        _passwordController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: "Poppins",
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => registerBloc
                              .add(RegisterNavigateToLoginPageEvent()),
                          child: Text(
                            " Sign in",
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

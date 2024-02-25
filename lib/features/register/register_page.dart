import 'package:e_commerce_app/components/email_textfield.dart';
import 'package:e_commerce_app/components/password_textfield.dart';
import 'package:e_commerce_app/features/login/login_page.dart';
import 'package:e_commerce_app/features/login/widget/sign_in_button.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Column(
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
                PasswordTextField(controller: _passwordController),
                const SizedBox(
                  height: 15,
                ),
                const SignInButton(
                  text: "Sign in",
                  displayPrefixImage: false,
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
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                      ),
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
      ),
    );
  }
}

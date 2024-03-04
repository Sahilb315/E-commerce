// ignore_for_file: unrelated_type_equality_checks

import 'package:e_commerce_app/features/login/ui/login_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to the Profile Page!'),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route == const ProfilePage());
                HelperFunctions.navigateToScreenRightLeftAnimation(
                    context, const LoginPage());
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}

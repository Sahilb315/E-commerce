import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/login/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStateChangesPage extends StatelessWidget {
  const AuthStateChangesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigationPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

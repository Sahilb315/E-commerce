// ignore_for_file: unrelated_type_equality_checks, type_literal_in_constant_pattern

import 'package:e_commerce_app/features/login/ui/login_page.dart';
import 'package:e_commerce_app/features/profile/bloc/profile_bloc.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    profileBloc.add(ProfileInitialFetchEvent());
    super.initState();
  }

  final profileBloc = ProfileBloc();

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProfileLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case ProfileLoadedState:
              final user = (state as ProfileLoadedState).userModel;
              return Center(
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Name:",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                      title: Text(
                        user.fullName,
                        style: TextStyle(
                          color: AppColors.backgroundColor.withOpacity(0.8),
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                    ),
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
              );
            case ProfileErrorState:
              return const Center(
                child: Text("Error..."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

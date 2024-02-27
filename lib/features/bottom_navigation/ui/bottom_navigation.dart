import 'package:e_commerce_app/features/account/ui/account_page.dart';
import 'package:e_commerce_app/features/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:e_commerce_app/features/cart/ui/cart_page.dart';
import 'package:e_commerce_app/features/explore/ui/explore_page.dart';
import 'package:e_commerce_app/features/home/ui/home_page.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationPage extends StatelessWidget {
  BottomNavigationPage({super.key});

  final navigationBloc = BottomNavigationBloc();

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    CartPage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      bloc: navigationBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 20,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.backgroundColor.withOpacity(0.7),
            unselectedItemColor: AppColors.blueGray300,
            selectedLabelStyle: TextStyle(color: AppColors.backgroundColor),
            unselectedLabelStyle: TextStyle(color: AppColors.blueGray300),
            onTap: (value) {
              navigationBloc.add(NavigationTabChange(index: value));
            },
            currentIndex: state.tabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: "Account",
              ),
            ],
          ),
          body: _pages[state.tabIndex],
        );
      },
    );
  }
}

// ignore_for_file: type_literal_in_constant_pattern
import 'package:e_commerce_app/features/home/bloc/home_bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/ui/widgets/home_widget.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
    user = FirebaseAuth.instance.currentUser;
  }

  final pageController = PageController();

  User? user;
  final homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.transparent,
      //   title: const Text('HOME PAGE'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         CupertinoIcons.heart,
      //         color: AppColors.blueGray300,
      //       ),
      //     ),
      //   ],
      // ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case HomeSuccessState:
              final successState = state as HomeSuccessState;
              List<ProductModel> allProducts = List.of(successState.products)
                ..shuffle();
              final bestSellerProducts = successState.bestSellerProducts;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 18,
                            color: AppColors.backgroundColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 24.0,
                              top: 10.0,
                              bottom: 10.0,
                              left: 10,
                            ),
                            child: Text(
                              "Seach Products",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.blueGray300,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    floating: false,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart,
                          color: AppColors.blueGray300,
                        ),
                      ),
                    ],
                    flexibleSpace: const FlexibleSpaceBar(
                      titlePadding: EdgeInsets.all(20),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        MyHomeWidget(
                          pageController: pageController,
                          bestSellerProducts: bestSellerProducts,
                          allProducts: allProducts,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            case HomeErrorState:
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

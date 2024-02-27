// ignore_for_file: type_literal_in_constant_pattern
import 'dart:developer';

import 'package:e_commerce_app/features/favourite/ui/favourite_page.dart';
import 'package:e_commerce_app/features/home/bloc/home_bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/ui/widgets/banner_view.dart';
import 'package:e_commerce_app/features/home/ui/widgets/product_tile.dart';
import 'package:e_commerce_app/features/product_detail/ui/product_details_page.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  // PageController pageController = PageController(initialPage: 0);

  Future<void> _refreshPage() async {
    homeBloc.add(HomeInitialEvent());
  }

  // @override
  // void dispose() {
  //   pageController.dispose();
  //   super.dispose();
  // }

  User? user;
  final homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToFavouritePageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const FavouritePage(),
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
          } else if (state is HomeNavigateToProductPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ProductDetailsPage(
                  productModel: state.productModel,
                ),
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
          }
        },
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
              return RefreshIndicator.adaptive(
                color: AppColors.backgroundColor,
                onRefresh: _refreshPage,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.search,
                                  size: 18,
                                  color: AppColors.backgroundColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 24.0,
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
                        ),
                      ),
                      centerTitle: true,
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      floating: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            homeBloc.add(HomeFavouriteBtnClickedEvent());
                          },
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.22,
                                  child: const HomeBannerView(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Best Sellers",
                                      style: TextStyle(
                                        color: MyColorSchemes
                                            .primaryColorScheme.onPrimary
                                            .withOpacity(1),
                                        fontSize: 18,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "See More",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bestSellerProducts.length,
                                  itemBuilder: (context, index) {
                                    log(bestSellerProducts.length.toString());
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        bottom: 8.0,
                                      ),
                                      child: SizedBox(
                                        width: 145,
                                        child: ProductTile(
                                          onTap: () {
                                            homeBloc.add(
                                              HomeProductTileClickedEvent(
                                                productModel:
                                                    bestSellerProducts[index],
                                              ),
                                            );
                                          },
                                          productModel:
                                              bestSellerProducts[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.17,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          "https://images.unsplash.com/photo-1586525198428-225f6f12cff5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjJ8fHNuZWFrZXJ8ZW58MHx8MHx8fDA%3D",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 8,
                                    mainAxisExtent:
                                        MediaQuery.sizeOf(context).height * 0.3,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                  ),
                                  itemCount: allProducts.length,
                                  itemBuilder: (context, index) {
                                    return ProductTile(
                                      onTap: () {
                                        homeBloc.add(
                                          HomeProductTileClickedEvent(
                                            productModel: allProducts[index],
                                          ),
                                        );
                                      },
                                      productModel: allProducts[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

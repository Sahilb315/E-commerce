// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:e_commerce_app/features/product_category/ui/product_category_page.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final exploreBloc = ExploreBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ExploreBloc, ExploreState>(
        bloc: exploreBloc,
        listenWhen: (previous, current) => current is ExploreActionState,
        listener: (context, state) {
          if (state is ExploreNavigateToProductCategoryPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ProductCategoryPage(
                  categoryName: state.categoryName,
                  categoryId: state.categoryId,
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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 11,
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
                              left: 10,
                            ),
                            child: Text(
                              "Seach Products",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey.shade500,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: AppColors.blueGray300,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Man Fashion",
                            style: MyTextThemes.myTextTheme().titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryName: "Clothing",
                                    categoryId: 110,
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/men-clothing.png",
                                heading: "Clothing",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 112,
                                    categoryName: "Accessories"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/men-accessory.png",
                                heading: "Accessories",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 113,
                                    categoryName: "Watches"
                                  ));
                                },
                                assetImagePath: "assets/category/men-watch.png",
                                heading: "Watches",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Women Fashion",
                            style: MyTextThemes.myTextTheme().titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 116,
                                    categoryName: "Dresses"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/women-clothing.png",
                                heading: "Dresses",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 118,
                                    categoryName: "HandBags"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/women-handbag.png",
                                heading: "HandBags",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 123,
                                    categoryName: "Jewelry"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/women-jewelry.png",
                                heading: "Jewelry",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 50,
                                    categoryName: "Beauty"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/women-beauty.png",
                                heading: "Beauty",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Electronic Items",
                            style: MyTextThemes.myTextTheme().titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 79,
                                    categoryName: "Cameras"
                                  ));
                                },
                                assetImagePath: "assets/category/camera.png",
                                heading: "Cameras",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 69,
                                    categoryName: "TV Products"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/television.png",
                                heading: "TV Products",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 56,
                                    categoryName: "Computers"
                                  ));
                                },
                                assetImagePath: "assets/category/computer.png",
                                heading: "Computers",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 243,
                                    categoryName: "Games"
                                  ));
                                },
                                assetImagePath: "assets/category/games.png",
                                heading: "Games",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 71,
                                    categoryName: "Headphones"
                                  ));
                                },
                                assetImagePath:
                                    "assets/category/headphones.png",
                                heading: "Headphones",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Other Items",
                            style: MyTextThemes.myTextTheme().titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 166,
                                    categoryName: "Furniture"
                                  ));
                                },
                                assetImagePath: "assets/category/furniture.png",
                                heading: "Furniture",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 270,
                                    categoryName: "Toys"
                                  ));
                                },
                                assetImagePath: "assets/category/toys.png",
                                heading: "Toys",
                              ),
                              CategoryContainer(
                                onTap: () {
                                  exploreBloc.add(
                                      ExploreNavigateToProductCategorisedEvent(
                                    categoryId: 104,
                                    categoryName: "Suitcases"
                                  ));
                                },
                                assetImagePath: "assets/category/suitcase.png",
                                heading: "Suitcases",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

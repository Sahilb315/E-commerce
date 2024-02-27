// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        listener: (context, state) {},
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
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/men-clothing.png",
                                heading: "Clothing",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/men-accessory.png",
                                heading: "Accessories",
                              ),
                              CategoryContainer(
                                onTap: () {},
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
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/women-clothing.png",
                                heading: "Dresses",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/women-handbag.png",
                                heading: "HandBags",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/women-jewelry.png",
                                heading: "Jewelry",
                              ),
                              CategoryContainer(
                                onTap: () {},
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
                                onTap: () {},
                                assetImagePath: "assets/category/camera.png",
                                heading: "Cameras",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath:
                                    "assets/category/television.png",
                                heading: "TV Products",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath: "assets/category/computer.png",
                                heading: "Computers",
                              ),
                              CategoryContainer(
                                onTap: () {},
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
                                onTap: () {},
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
                                onTap: () {},
                                assetImagePath: "assets/category/furniture.png",
                                heading: "Furniture",
                              ),
                              CategoryContainer(
                                onTap: () {},
                                assetImagePath: "assets/category/toys.png",
                                heading: "Toys",
                              ),
                              CategoryContainer(
                                onTap: () {},
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

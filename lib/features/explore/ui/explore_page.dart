// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/electronic_category.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/men_category.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/other_category.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/women_category.dart';
import 'package:e_commerce_app/features/favourite/ui/favourite_page.dart';
import 'package:e_commerce_app/features/product_category/ui/product_category_page.dart';
import 'package:e_commerce_app/features/search/ui/search_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
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
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              ProductCategoryPage(
                categoryName: state.categoryName,
                categoryId: state.categoryId,
              ),
            );
          } else if (state is ExploreNavigateToSearchPageActionState) {
            HelperFunctions.pushNavigateToScreenLeftRightAnimation(
              context,
              SearchPage(
                products: state.products,
              ),
            );
          } else if (state is ExploreNavigateToFavPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const FavouritePage(),
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
                    onTap: () {
                      exploreBloc.add(ExploreNavigateToSearchPageEvent());
                    },
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
                      onPressed: () {
                        exploreBloc.add(ExploreNavigateToFavPageEvent());
                      },
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
                          const SizedBox(height: 12),
                          MenFashionCategories(exploreBloc: exploreBloc),
                          const SizedBox(height: 24),
                          Text(
                            "Women Fashion",
                            style: MyTextThemes.myTextTheme().titleMedium,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          WomenFashionCategories(exploreBloc: exploreBloc),
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
                          ElectronicsCategory(exploreBloc: exploreBloc),
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
                          OthersCategory(exploreBloc: exploreBloc),
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

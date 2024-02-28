import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:flutter/material.dart';



class WomenFashionCategories extends StatelessWidget {
  const WomenFashionCategories({
    super.key,
    required this.exploreBloc,
  });

  final ExploreBloc exploreBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 116, categoryName: "Dresses"));
          },
          assetImagePath: "assets/category/women-clothing.png",
          heading: "Dresses",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 118, categoryName: "HandBags"));
          },
          assetImagePath: "assets/category/women-handbag.png",
          heading: "HandBags",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 123, categoryName: "Jewelry"));
          },
          assetImagePath: "assets/category/women-jewelry.png",
          heading: "Jewelry",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 50, categoryName: "Beauty"));
          },
          assetImagePath: "assets/category/women-beauty.png",
          heading: "Beauty",
        ),
      ],
    );
  }
}

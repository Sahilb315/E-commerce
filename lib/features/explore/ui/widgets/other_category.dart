import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:flutter/material.dart';


class OthersCategory extends StatelessWidget {
  const OthersCategory({
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
            exploreBloc.add(
                ExploreNavigateToProductCategorisedEvent(
                    categoryId: 166,
                    categoryName: "Furniture"));
          },
          assetImagePath: "assets/category/furniture.png",
          heading: "Furniture",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(
                ExploreNavigateToProductCategorisedEvent(
                    categoryId: 270,
                    categoryName: "Toys"));
          },
          assetImagePath: "assets/category/toys.png",
          heading: "Toys",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(
                ExploreNavigateToProductCategorisedEvent(
                    categoryId: 104,
                    categoryName: "Suitcases"));
          },
          assetImagePath: "assets/category/suitcase.png",
          heading: "Suitcases",
        ),
      ],
    );
  }
}
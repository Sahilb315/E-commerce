import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:flutter/material.dart';



class MenFashionCategories extends StatelessWidget {
  const MenFashionCategories({
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
              categoryName: "Clothing",
              categoryId: 110,
            ));
          },
          assetImagePath: "assets/category/men-clothing.png",
          heading: "Clothing",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 112, categoryName: "Accessories"));
          },
          assetImagePath: "assets/category/men-accessory.png",
          heading: "Accessories",
        ),
        CategoryContainer(
          onTap: () {
            exploreBloc.add(ExploreNavigateToProductCategorisedEvent(
                categoryId: 113, categoryName: "Watches"));
          },
          assetImagePath: "assets/category/men-watch.png",
          heading: "Watches",
        ),
      ],
    );
  }
}

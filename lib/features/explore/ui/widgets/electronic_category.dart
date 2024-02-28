import 'package:e_commerce_app/features/explore/bloc/explore_bloc.dart';
import 'package:e_commerce_app/features/explore/ui/widgets/category_container.dart';
import 'package:flutter/material.dart';


class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({
    super.key,
    required this.exploreBloc,
  });

  final ExploreBloc exploreBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            CategoryContainer(
              onTap: () {
                exploreBloc.add(
                    ExploreNavigateToProductCategorisedEvent(
                        categoryId: 79,
                        categoryName: "Cameras"));
              },
              assetImagePath:
                  "assets/category/camera.png",
              heading: "Cameras",
            ),
            CategoryContainer(
              onTap: () {
                exploreBloc.add(
                    ExploreNavigateToProductCategorisedEvent(
                        categoryId: 69,
                        categoryName: "TV Products"));
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
                        categoryName: "Computers"));
              },
              assetImagePath:
                  "assets/category/computer.png",
              heading: "Computers",
            ),
            CategoryContainer(
              onTap: () {
                exploreBloc.add(
                    ExploreNavigateToProductCategorisedEvent(
                        categoryId: 243,
                        categoryName: "Games"));
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
                        categoryName: "Headphones"));
              },
              assetImagePath:
                  "assets/category/headphones.png",
              heading: "Headphones",
            ),
          ],
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/ui/widgets/banner_view.dart';
import 'package:e_commerce_app/features/home/ui/widgets/product_tile.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({
    super.key,
    required this.pageController,
    required this.bestSellerProducts,
    required this.allProducts,
  });

  final PageController pageController;
  final List<ProductModel> bestSellerProducts;
  final List<ProductModel> allProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: HomeBannerView(pageController: pageController),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 10,
            child: SmoothPageIndicator(
              effect: WormEffect(
                dotColor: AppColors.blueGray300,
                activeDotColor: AppColors.backgroundColor,
                dotHeight: 10,
                dotWidth: 10,
              ),
              controller: pageController,
              count: 3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Best Sellers",
                style: TextStyle(
                  color: MyColorSchemes.primaryColorScheme.onPrimary
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
                    productModel: bestSellerProducts[index],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.17,
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              mainAxisExtent: MediaQuery.sizeOf(context).height * 0.3,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
            ),
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              return ProductTile(
                productModel: allProducts[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

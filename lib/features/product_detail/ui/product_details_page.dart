// ignore_for_file: type_literal_in_constant_pattern

import 'dart:developer';

import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/repo/home_repo.dart';
import 'package:e_commerce_app/features/product_detail/bloc/product_detail_bloc.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/features/shipping/ui/pages/shipping_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final productBloc = ProductDetailBloc();

  @override
  void initState() {
    productBloc.add(ProductDetailInitialEvent());
    super.initState();
    log("Product List From Home Repo ${homeRepo.productsList.toString()}");
  }

  final homeRepo = HomeRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          widget.productModel.title.toString(),
          maxLines: 1,
          style: TextStyle(
            color: MyColorSchemes.primaryColorScheme.onPrimary.withOpacity(1),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        bloc: productBloc,
        buildWhen: (previous, current) => current is! ProductDetailActionState,
        listenWhen: (previous, current) => current is ProductDetailActionState,
        listener: (context, state) {
          if (state is ProductAddedToFavouriteActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backgroundColor.withOpacity(0.7),
                content: const Text("Product is added to Favourites"),
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is ProductRemovedFromFavouriteActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backgroundColor.withOpacity(0.7),
                content: const Text("Product is removed from Favourites"),
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is ProductDetailProductAddedToCartActionState) {
            final cartList = state.cartItems;
            int itemsInCart = 0;
            double cartPriceTotal = 0;
            for (var element in cartList) {
              int productQuantity = element.totalItemCount!;
              itemsInCart += productQuantity;
              cartPriceTotal += element.price * productQuantity;
            }
            productAddedBottomSheet(context, itemsInCart, cartPriceTotal);
          } else if (state is ProductDetailNavigateToCartPageActionState) {
            Navigator.pop(context);

            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const BottomNavigationPage(index: 2),
            );
          } else if (state
              is ProductDetailNavigateToShipPageOnBuyNowActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              ShippingPage(
                productModel: widget.productModel,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductDetailLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case ProductDetailLoadedState:
              final successState = state as ProductDetailLoadedState;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.29,
                      alignment: Alignment.center,
                      child: Image.network(
                        widget.productModel.imgUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.productModel.title.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: MyColorSchemes
                                        .primaryColorScheme.onPrimary
                                        .withOpacity(1),
                                    fontSize: 22,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (successState.favProducts
                                      .contains(widget.productModel)) {
                                    productBloc.add(
                                      ProductDetailProductRemovedFromFavouriteEvent(
                                        productModel: widget.productModel,
                                      ),
                                    );
                                  } else {
                                    productBloc.add(
                                      ProductDetailProductAddedToFavouriteEvent(
                                        productModel: widget.productModel,
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  successState.favProducts
                                          .contains(widget.productModel)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: AppColors.backgroundColor,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$${widget.productModel.price}",
                            style: TextStyle(
                              color: AppColors.backgroundColor.withOpacity(1),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.productModel.listPrice == 0
                                ? ""
                                : "\$${widget.productModel.listPrice}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 17,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            widget.productModel.title.toString(),
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: RatingBar.builder(
                              itemPadding: const EdgeInsets.all(0),
                              allowHalfRating: true,
                              maxRating: 5,
                              minRating: 1,
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                              initialRating: double.parse(
                                      widget.productModel.stars.toString())
                                  .toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              itemSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            case ProductDetailErrorState:
              return const Center(
                child: Text("Error.."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.sizeOf(context).height * 0.2,
        color: Colors.white,
        child: Column(
          children: [
            CustomButton(
              heading: "Add to cart",
              onTap: () {
                productBloc.add(
                  ProductDetailProductAddToCartEvent(
                    productModel: CartModel(
                      stars: widget.productModel.stars,
                      price: widget.productModel.price,
                      listPrice: widget.productModel.listPrice,
                      totalItemCount: 1,
                      asin: widget.productModel.asin,
                      title: widget.productModel.title,
                      imgUrl: widget.productModel.imgUrl,
                      category_id: widget.productModel.category_id,
                      reviews: widget.productModel.reviews,
                      isBestSeller: widget.productModel.isBestSeller,
                      boughtInLastMonth: widget.productModel.boughtInLastMonth,
                      productURL: widget.productModel.productURL,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              heading: "Buy now",
              onTap: () {
                productBloc.add(ProductDetailNavigateToShipPageOnBuyNowEvent(
                  productModel: widget.productModel,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> productAddedBottomSheet(
    BuildContext context,
    int itemsInCart,
    double cartPriceTotal,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12,
            ),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Image.asset('assets/tick.png'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Added to cart",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              widget.productModel.title.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "\$${widget.productModel.price}",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Cart Subtotal ($itemsInCart): \$${cartPriceTotal.round()}",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () {
                      productBloc.add(ProductDetailNavigateToCartPageEvent());
                    },
                    heading: "Go to cart",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

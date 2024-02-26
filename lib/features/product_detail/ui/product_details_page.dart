import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/product_detail/bloc/product_detail_bloc.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel productModel;
  ProductDetailsPage({super.key, required this.productModel});

  final productBloc = ProductDetailBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          productModel.title.toString(),
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
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is ProductRemovedFromFavouriteActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backgroundColor.withOpacity(0.7),
                content: const Text("Product is removed from Favourites"),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.29,
                  alignment: Alignment.center,
                  child: Image.network(
                    productModel.imgUrl.toString(),
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
                              productModel.title.toString(),
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
                              productBloc.add(
                                ProductFavouriteButtonClickedEvent(
                                  productModel: productModel,
                                ),
                              );
                            },
                            icon: Icon(
                              state.runtimeType == ProductExistsInFavState
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
                        "\$${productModel.price}",
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
                        productModel.listPrice == 0
                            ? ""
                            : "\$${productModel.listPrice}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 17,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        productModel.title.toString(),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: RatingBar.builder(
                          itemPadding: const EdgeInsets.all(0),
                          allowHalfRating: true,
                          maxRating: 5,
                          minRating: 1,
                          ignoreGestures: true,
                          onRatingUpdate: (value) {},
                          initialRating:
                              double.parse(productModel.stars.toString())
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
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.sizeOf(context).height * 0.2,
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.transparent),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Add to cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.transparent),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Buy now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

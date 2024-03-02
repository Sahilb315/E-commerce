// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/home/ui/widgets/product_tile.dart';
import 'package:e_commerce_app/features/product_category/bloc/product_category_bloc.dart';
import 'package:e_commerce_app/features/product_detail/ui/product_details_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductCategoryPage(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  final productCategoryBloc = ProductCategoryBloc();

  @override
  void initState() {
    productCategoryBloc.add(
      ProductCategoryFetchDataEvent(categoryId: widget.categoryId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
        bloc: productCategoryBloc,
        listenWhen: (previous, current) =>
            current is ProductCategoryActionState,
        buildWhen: (previous, current) =>
            current is! ProductCategoryActionState,
        listener: (context, state) {
          if (state is ProductCatgoryNavigateToProductActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              ProductDetailsPage(productModel: state.productModel),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductCategoryLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case ProductCategoryLoadedState:
              final successState = state as ProductCategoryLoadedState;
              final categorisedProducts = successState.categorisedProductLists;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    title: Text(widget.categoryName),
                    floating: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 8,
                          ),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              mainAxisExtent:
                                  MediaQuery.sizeOf(context).height * 0.3,
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                            ),
                            itemCount: categorisedProducts.length,
                            itemBuilder: (context, index) {
                              return ProductTile(
                                onTap: () {
                                  productCategoryBloc.add(
                                    ProductCategoryNavigateToProductDetailPageEvent(
                                      productModel: categorisedProducts[index],
                                    ),
                                  );
                                },
                                productModel: categorisedProducts[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

            case ProductCategoryErrorState:
              return const Center(
                child: Text("Error..."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

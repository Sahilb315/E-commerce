// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_commerce_app/features/favourite/ui/widgets/favorite_tile.dart';
import 'package:e_commerce_app/features/product_detail/ui/product_details_page.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    favBloc.add(FavouritesFetchEvent());
    super.initState();
  }

  final favBloc = FavouriteBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        bloc: favBloc,
        listenWhen: (previous, current) => current is FavouriteActionState,
        buildWhen: (previous, current) => current is! FavouriteActionState,
        listener: (context, state) {
          if (state is FavouriteNavigateToProductDetailsPageActionState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ProductDetailsPage(
                  productModel: state.product,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          } else if (state is FavouriteProductRemovedFromListActionState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.backgroundColor.withOpacity(0.7),
                content: const Text("Product is deleted from Favourites"),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FavouriteLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case FavouriteLoadedState:
              final successState = state as FavouriteLoadedState;
              final favProducts = successState.favouriteProducts;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      "Favorite Product",
                      style: TextStyle(
                        color: MyColorSchemes.primaryColorScheme.onPrimary
                            .withOpacity(1),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 8,
                                mainAxisExtent:
                                    MediaQuery.sizeOf(context).height * 0.35,
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                              ),
                              itemCount: favProducts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FavouriteTile(
                                    productModel: favProducts[index],
                                    onDeleteTap: () {
                                      favBloc.add(
                                        FavouriteProductRemovedEvent(
                                          productModel: favProducts[index],
                                        ),
                                      );
                                    },
                                    onTap: () {
                                      favBloc.add(
                                        FavouriteNavigateToProductDetailsPageEvent(
                                          productModel: favProducts[index],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            case FavouriteErrorState:
              return const Center(
                child: Text("Error.."),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

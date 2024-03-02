// ignore_for_file: type_literal_in_constant_pattern

import 'package:e_commerce_app/features/bottom_navigation/ui/bottom_navigation.dart';
import 'package:e_commerce_app/features/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/cart/ui/widgets/cart_tile.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/product_detail/ui/product_details_page.dart';
import 'package:e_commerce_app/features/product_detail/ui/widgets/custom_button.dart';
import 'package:e_commerce_app/features/shipping/ui/pages/shipping_page.dart';
import 'package:e_commerce_app/helper/helper_functions.dart';
import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Your Cart",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(CupertinoIcons.bell),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        bloc: cartBloc,
        listener: (context, state) {
          if (state is CartNavigateToProductDetailPageActionState) {
            final cartModel = state.cartProduct;
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              ProductDetailsPage(
                productModel: ProductModel(
                  stars: cartModel.stars,
                  price: cartModel.price,
                  listPrice: cartModel.listPrice,
                  title: cartModel.title,
                  imgUrl: cartModel.imgUrl,
                  category_id: cartModel.category_id,
                  boughtInLastMonth: cartModel.boughtInLastMonth,
                  productURL: cartModel.productURL,
                  reviews: cartModel.reviews,
                  isBestSeller: cartModel.isBestSeller,
                  asin: cartModel.asin,
                ),
              ),
            );
          } else if (state is CartNavigateToShippingPageActionState) {
            HelperFunctions.navigateToScreenRightLeftAnimation(
              context,
              const ShippingPage(),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.backgroundColor.withOpacity(0.7),
                  strokeCap: StrokeCap.round,
                ),
              );
            case CartEmptyState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 80,
                      "assets/cart_empty.svg",
                    ),
                    Text(
                      "Your cart is empty",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const BottomNavigationPage(index: 0),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
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
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.backgroundColor.withOpacity(0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 25,
                          ),
                          child: Text(
                            "Shop now",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            case CartLoadedState:
              final successState = state as CartLoadedState;
              List<CartModel> cartProducts = successState.cartProducts;
              double itemsPriceTotal = 0;
              int productQuantity = 1;
              for (var i = 0; i < cartProducts.length; i++) {
                productQuantity = cartProducts[i].totalItemCount!;
                itemsPriceTotal += cartProducts[i].price * productQuantity;
              }
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.35,
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return CartTile(
                          cartProduct: cartProducts[index],
                          onTileTap: () {
                            cartBloc.add(
                              CartNavigateToProductDetailsPageEvent(
                                cartProduct: cartProducts[index],
                              ),
                            );
                          },
                          onDecrementTap: () {
                            cartBloc.add(CartRemoveProductEvent(
                              cartModel: cartProducts[index],
                            ));
                          },
                          onDeleteAllTap: () {
                            cartBloc.add(CartDeleteAllProductEvent(
                              cartModel: cartProducts[index],
                            ));
                          },
                          onIncrementTap: () {
                            cartBloc.add(CartAddProductEvent(
                              cartModel: cartProducts[index],
                            ));
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gray400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Enter Coupon Code",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: AppColors.backgroundColor
                                      .withOpacity(0.8),
                                ),
                                width: 70,
                                height: double.maxFinite,
                                child: const Text(
                                  "Apply",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.24,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gray400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Items($productQuantity)",
                                      style: TextStyle(
                                        color: AppColors.blueGray300,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "\$$itemsPriceTotal",
                                      style:
                                          MyTextThemes.myTextTheme().labelSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Shipping",
                                      style: TextStyle(
                                        color: AppColors.blueGray300,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "\$40.00",
                                      style:
                                          MyTextThemes.myTextTheme().labelSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Import Charges",
                                      style: TextStyle(
                                        color: AppColors.blueGray300,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "\$116.00",
                                      style:
                                          MyTextThemes.myTextTheme().labelSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Price",
                                      style: TextStyle(
                                        color: MyColorSchemes
                                            .primaryColorScheme.onPrimary
                                            .withOpacity(1),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "\$${(itemsPriceTotal + 40 + 116).round()}.00",
                                      style: TextStyle(
                                        color: MyColorSchemes
                                            .primaryColorScheme.primary
                                            .withOpacity(1),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          heading: "Check out",
                          onTap: () {
                            cartBloc.add(CartNavigateToShippingPageEvent(
                              cartProducts: cartProducts,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            case CartErrorState:
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
